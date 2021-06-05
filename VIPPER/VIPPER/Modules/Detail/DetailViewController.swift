//
//  DetailViewController.swift
//  VIPER
//
//  Created by Manh Pham on 2/8/21.
//

import UIKit

class DetailViewController: BaseViewController {

    var presenter: DetailPresenterInterface!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}

extension DetailViewController: DetailViewInterface {
    
}
