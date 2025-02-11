//
//  ListViewController.swift
//  ProjectTemplete
//
//  Created by Bob on 2025/2/11.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import MJRefresh

class ListViewController: UIViewController {

    private let viewModel = ListViewModel()
    private let disposeBag = DisposeBag()
    weak var coordinator: ListCoordinator?

    private lazy var tableView: UITableView = {
        let tempTableView = UITableView()
        tempTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tempTableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            self?.viewModel.refreshTrigger.onNext(())
        })
        tempTableView.backgroundColor = .yellow
        
        tempTableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { [weak self] in
            self?.viewModel.loadMoreTrigger.onNext(())
        })
        
        
        return tempTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBindings()
        
    }

    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints{ make in           
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
        }
    }
    
    private func setupBindings() {
        
        viewModel.items
            .bind(to: tableView.rx.items(cellIdentifier: "Cell")) { _, item, cell in
                cell.textLabel?.text = item.title
            }
            .disposed(by: disposeBag)
        
        viewModel.isRefreshing
            .bind(onNext: { [weak self] isRefreshing in
                if !isRefreshing {
                    self?.tableView.mj_header?.endRefreshing()
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.isLoadingMore
            .bind(onNext: { [weak self] isLoadingMore in
                if !isLoadingMore {
                    self?.tableView.mj_footer?.endRefreshing()
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.hasMoreData
            .subscribe(onNext: { [weak self] hasMore in
                self?.tableView.mj_footer?.isHidden = !hasMore
            })
            .disposed(by: disposeBag)
        
        
        tableView.mj_header?.beginRefreshing()
    }
}
