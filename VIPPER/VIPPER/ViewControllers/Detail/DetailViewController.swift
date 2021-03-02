//
//  DetailViewController.swift
//  MVC
//
//  Created by Manh Pham on 2/8/21.
//

import UIKit

class DetailViewController: UIViewController {

    static var instantiate: DetailViewController {
        let st = UIStoryboard(name: "Detail", bundle: nil)
        let vc = st.instantiateInitialViewController() as! DetailViewController
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}
