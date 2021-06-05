//
//  MainViewController.swift
//  VIPER
//
//  Created by Manh Pham on 2/8/21.
//

import UIKit
import PKHUD

class MainViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
        
    var presenter: MainPresenterInterface!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        navigationItem.title = "Events"
        let logOut = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.rightBarButtonItem = logOut
        
        presenter.viewDidLoad()
    }
    
    @objc func handleLogout() {
        presenter.didTapLogout()
    }
    
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = presenter.elements[indexPath.row].repo?.name
        return cell
    }
    
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.navigationToDetailScreen(item: presenter.elements[indexPath.row])
    }
    
}

extension MainViewController: MainViewInterface {
    
    func showAlert(title: String, message: String) {
        AppHelper.shared.showAlert(title: title, message: message)
    }
    
    func didLoadData() {
        tableView.reloadData()
    }
    
    func showLoading() {
        HUD.show(.progress)
    }
    
    func hideLoading() {
        PKHUD.sharedHUD.hide()
    }
        
}
