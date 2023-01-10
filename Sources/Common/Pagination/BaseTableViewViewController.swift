//
//  BaseTableViewViewController.swift
//  MyApp
//
//  Created by Manh Pham on 3/18/20.
//

import UIKit
import MJRefresh
import RxSwift
import RxCocoa

open class BaseTableViewViewController: BaseViewController, ViewControllerPageable {

    public let headerRefreshTrigger = PublishRelay<Void>()
    public let footerLoadMoreTrigger = PublishRelay<Void>()
    public let isEnableLoadMore = PublishRelay<Bool>()
    public let isHeaderLoading = PublishRelay<Bool>()
    public let isFooterLoading = PublishRelay<Bool>()
    public let isEmptyData = PublishRelay<Bool>()
    
    @IBOutlet public weak var tableView: UITableView!
    
    open override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    open override func setupUI() {
        super.setupUI()
        
        tableView.tableFooterView = UIView()
    }
        
    open override func bindDatas() {
        super.bindDatas()
        
        // header
        tableView.mj_header = viewForHeaderOfTableView()
        isHeaderLoading
            .bind(to: rx.isAnimatingHeader)
            .disposed(by: disposeBag)
        
        // footer
        tableView.mj_footer = viewForFooterOfTableView()

        // check logic animation footer
        Observable
            .combineLatest(isFooterLoading, isEnableLoadMore) { value, isEnable in
                return isEnable ? value : nil
            }
            .compactMap { $0 }
            .asDriverOnErrorJustComplete()
            .drive(rx.isAnimatingFooter)
            .disposed(by: disposeBag)

        // no data
        isEmptyData
            .bind(to: rx.isEmpyData)
            .disposed(by: disposeBag)

        // loadmore
        isEnableLoadMore
            .bind(to: rx.isEnableLoadMoreBinder)
            .disposed(by: disposeBag)
    }
    
    func viewForHeaderOfTableView() -> MJRefreshHeader? {
        let header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            self?.headerRefreshTrigger.accept(())
        })
        header.lastUpdatedTimeLabel?.isHidden = true
        header.stateLabel?.isHidden = true
        return header
    }
    
    func viewForFooterOfTableView() -> MJRefreshFooter? {
        let footer = MJRefreshAutoNormalFooter(refreshingBlock: { [weak self] in
            self?.footerLoadMoreTrigger.accept(())
        })
        footer.setTitle("", for: .noMoreData)
        footer.setTitle("", for: .willRefresh)
        footer.setTitle("", for: .pulling)
        footer.setTitle("Loading...", for: .refreshing)
        footer.setTitle("", for: .idle)
        return footer
    }
    
    func viewForEmptyDataOfTableView() -> UIView {
        return UIView()
    }
    
    func setNoDataView() {
        tableView.backgroundView = viewForEmptyDataOfTableView()
    }
    
    func removeNoDataView() {
        tableView.backgroundView = nil
    }
    
}

extension Reactive where Base: BaseTableViewViewController {
    
    var isEnableLoadMoreBinder: Binder<Bool> {
        return Binder(base) { viewController, enable in
            if enable {
                viewController.tableView.mj_footer?.resetNoMoreData()
            } else {
                viewController.tableView.mj_footer?.endRefreshingWithNoMoreData()
            }
        }
    }
    
    var isAnimatingHeader: Binder<Bool> {
        return Binder(base) { viewController, loading in
            if loading {
            } else {
                viewController.tableView.mj_header?.endRefreshing()
            }
        }
    }

    var isAnimatingFooter: Binder<Bool> {
        return Binder(base) { viewController, loading in
            if loading {
            } else {
                viewController.tableView.mj_footer?.endRefreshing()
            }
        }
    }
    
    var isEmpyData: Binder<Bool> {
        return Binder(base) { viewController, emptyData in
            if emptyData {
                viewController.setNoDataView()
            } else {
                viewController.removeNoDataView()
            }
        }
    }
}
