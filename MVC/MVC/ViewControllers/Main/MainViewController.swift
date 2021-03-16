//
//  MainViewController.swift
//  MVC
//
//  Created by Manh Pham on 2/8/21.
//

import UIKit
import RxSwift
import RxCocoa
import PKHUD

class MainViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var elements = [Event]()
    private let bag = DisposeBag()
    private var service: Service!
    
    static var instantiate: MainViewController {
        let st = UIStoryboard(name: "Main", bundle: nil)
        let vc = st.instantiateInitialViewController() as! MainViewController
        vc.service = API.shared
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        navigationItem.title = "Events"
        let logOut = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.rightBarButtonItem = logOut
        
        if let userName = AuthManager.shared.user?.login {
            HUD.show(.progress)
            service
                .userReceivedEvents(username: userName, page: 1)
                .do(onError: { error in
                    AppHelper.shared.showAlert(title: "Error", message: error.localizedDescription)
                })
                .asDriver(onErrorDriveWith: .empty())
                .drive(onNext: { result in
                    HUD.hide()
                    self.elements = result
                    self.tableView.reloadData()
                })
                .disposed(by: bag)
        }
        
    }
    
    @objc func handleLogout() {
        AuthManager.shared.logOut()
        UIWindow.shared?.rootViewController = UINavigationController(rootViewController: LoginViewController.instantiate)
    }
    
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = elements[indexPath.row].repo?.name
        return cell
    }
    
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController.instantiate
        let title = elements[indexPath.row].repo?.name
        vc.navigationItem.title = title
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
