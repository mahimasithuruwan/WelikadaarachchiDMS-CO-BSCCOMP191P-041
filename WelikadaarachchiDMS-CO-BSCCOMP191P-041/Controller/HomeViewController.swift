//
//  HomeViewController.swift
//  WelikadaarachchiDMS-CO-BSCCOMP191P-041
//
//  Created by Mahima Sithuruwan on 9/10/20.
//  Copyright © 2020 Mahima Sithuruwan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    private let authUser = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIsUserLoggedIn()
    }
    
    func checkIsUserLoggedIn() {
        if(authUser == "") {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginViewController())
                //let nav = UINavigationController(rootViewController: RegisterViewController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } else {
            //configure()
        }
    }

}
