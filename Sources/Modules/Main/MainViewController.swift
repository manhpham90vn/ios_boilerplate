//
//  MainViewController.swift
//  VIPER
//
//  Created by Manh Pham on 2/8/21.
//

import UIKit
import RxSwift
import RxCocoa
import MPInjector
import LocalDataViewer

final class MainViewController: BaseTableViewViewController {

    @Inject var presenter: MainPresenterInterface
    @Inject var log: Logger

    deinit {
        if Configs.shared.loggingDeinitEnabled {
            LogInfo("\(Swift.type(of: self)) Deinit")
        }
        LeakDetector.instance.expectDeallocate(object: presenter as AnyObject)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.inject(view: self)
    }
    
    override func setupUI() {
        super.setupUI()

        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        navigationItem.title = "Events"
        let logOut = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        let showLocalData = UIBarButtonItem(title: "Show Local Data", style: .plain, target: self, action: #selector(handleShowLocalData))
        navigationItem.rightBarButtonItems = [logOut, showLocalData]
        let log = UIBarButtonItem(title: "Log", style: .plain, target: self, action: #selector(showLog))
        let reload = UIBarButtonItem(title: "Reload", style: .plain, target: self, action: #selector(self.reload))
        navigationItem.leftBarButtonItems = [log, reload]
    }

    @objc
    func handleShowLocalData() {
        let vc = LocalDataViewer.getMenuVC()
        present(vc, animated: true, completion: nil)
    }
                                              
    @objc
    func reload() {
        presenter.reload()
    }
    
    @objc
    func showLog() {
        let data = log.getFile()
        let content = try? String(contentsOf: data)
        let pasteBoard = UIPasteboard.general
        pasteBoard.string = content
    }
    
    override func bindDatas() {
        super.bindDatas()

        guard let presenter = presenter as? MainPresenter else { return }
        Observable.just(()).bind(to: presenter.trigger).disposed(by: disposeBag)
        presenter.bind(paggingable: self)
        presenter.elements.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { _, element, cell in
            cell.textLabel?.text = element.name
        }
        .disposed(by: disposeBag)
    }

    @objc
    func handleLogout() {
        presenter.didTapLogout()
    }

}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let presenter = presenter as? MainPresenter else { return }
        presenter.navigationToDetailScreen(user: presenter.elements.value[indexPath.row])
    }
    
}

extension MainViewController: MainViewInterface {}
