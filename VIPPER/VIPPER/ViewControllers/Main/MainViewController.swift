//
//  MainViewController.swift
//  MVC
//
//  Created by Manh Pham on 2/8/21.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var elements = [Event]()
    private let bag = DisposeBag()
    
    static var instantiate: MainViewController {
        let st = UIStoryboard(name: "Home", bundle: nil)
        let vc = st.instantiateInitialViewController() as! MainViewController
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
            API.shared.userReceivedEvents(username: userName, page: 1)
                .do(onError: { error in
                    AppHelper.shared.showAlert(title: "Error", message: error.localizedDescription)
                })
                .asDriver(onErrorDriveWith: .empty())
                .drive(onNext: { result in
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
        print(elements[indexPath.row])
    }
    
}
