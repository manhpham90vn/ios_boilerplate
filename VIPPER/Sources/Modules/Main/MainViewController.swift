//
//  MainViewController.swift
//  VIPER
//
//  Created by Manh Pham on 2/8/21.
//

import UIKit
import PKHUD

final class MainViewController: BaseTableViewViewController {

    var presenter: MainPresenter!

    deinit {
        LogInfo("\(type(of: self)) Deinit")
        LeakDetector.instance.expectDeallocate(object: presenter as AnyObject)
    }

    override func setupUI() {
        super.setupUI()

        tableView.rx.setDelegate(self) ~ disposeBag
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        navigationItem.title = "Events"
        let logOut = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.rightBarButtonItem = logOut
    }

    override func bindViewModel() {
        super.bindViewModel()

        Observable.just(()) ~> presenter.trigger ~ disposeBag
        presenter.bind(isLoading: isLoading)
        presenter.bind(paggingable: self)
        presenter.elements.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { _, element, cell in
            cell.textLabel?.text = element.repo?.name
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
        presenter.navigationToDetailScreen(item: presenter.elements.value[indexPath.row])
    }
    
}

extension MainViewController: MainViewInterface {
    
    func showAlert(title: String, message: String) {
        AppHelper.shared.showAlert(title: title, message: message)
    }
}
