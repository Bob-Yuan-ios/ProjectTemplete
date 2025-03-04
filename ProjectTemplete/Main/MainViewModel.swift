//
//  MainViewModel.swift
//  ProjectTemplete
//
//  Created by Bob on 2025/2/8.
//

import Network
import Foundation

import RxSwift

class MainViewModel{
    
    private let apiService = APIService.shared
    private let disposeBag = DisposeBag()
    
    private let ntpServer = "time.apple.com" // NTP 服务器（可以换成 "pool.ntp.org"）
    private let ntpPort: NWEndpoint.Port = 123
    
    let responseData = PublishSubject<String>()
    
    func fetchUserData(id: Int){
        print("Fetching user data...")
        apiService.fetchTodo(id: id)
            .subscribe(onNext: { [weak self] result in
                self?.responseData.onNext(result)
            }, onError: {error in
                print("Error: \(error)")
            })
            .disposed(by: disposeBag)
    }
    
    func getNetworkTime(completion: @escaping (Date?) -> Void) {
        let connection = NWConnection(host: NWEndpoint.Host(ntpServer), port: ntpPort, using: .udp)

        connection.stateUpdateHandler = { state in
            switch state {
            case .ready:
                print("UDP 连接成功，发送 NTP 请求...")
                self.sendNTPRequest(connection, completion: completion)
            case .failed(let error):
                print("UDP 连接失败: \(error)")
                completion(nil)
            default:
                break
            }
        }

        connection.start(queue: .global())
    }

    private func sendNTPRequest(_ connection: NWConnection, completion: @escaping (Date?) -> Void) {
        var packet = [UInt8](repeating: 0, count: 48)
        packet[0] = 0x1B // 设置 NTP 请求头

        connection.send(content: Data(packet), completion: .contentProcessed { error in
            if let error = error {
                print("发送数据失败: \(error)")
                completion(nil)
                return
            }

            self.receiveNTPResponse(connection, completion: completion)
        })
    }

    private func receiveNTPResponse(_ connection: NWConnection, completion: @escaping (Date?) -> Void) {
        connection.receive(minimumIncompleteLength: 48, maximumLength: 48) { data, _, _, error in
            if let error = error {
                print("接收数据失败: \(error)")
                completion(nil)
                return
            }

            guard let data = data, data.count == 48 else {
                print("无效的 NTP 响应")
                completion(nil)
                return
            }

            let ntpTime = self.parseNTPResponse(data)
            completion(ntpTime)
        }
    }

    private func parseNTPResponse(_ data: Data) -> Date? {
        let NTP_TIMESTAMP_DELTA: UInt64 = 2_208_988_800 // 1970 到 1900 的时间差

        let seconds: UInt32 = data.withUnsafeBytes { $0.load(fromByteOffset: 40, as: UInt32.self) }
        let fraction: UInt32 = data.withUnsafeBytes { $0.load(fromByteOffset: 44, as: UInt32.self) }

        let unixTime = (UInt64(seconds.bigEndian) - NTP_TIMESTAMP_DELTA)
        let fractionPart = Double(fraction.bigEndian) / Double(UInt32.max)
        
        return Date(timeIntervalSince1970: TimeInterval(unixTime) + fractionPart)
    }
 
        
}
