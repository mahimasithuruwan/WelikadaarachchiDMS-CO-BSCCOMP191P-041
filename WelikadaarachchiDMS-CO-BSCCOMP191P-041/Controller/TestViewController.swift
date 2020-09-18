//
//  TestViewController.swift
//  WelikadaarachchiDMS-CO-BSCCOMP191P-041
//
//  Created by Mahima Sithuruwan on 9/17/20.
//  Copyright © 2020 Mahima Sithuruwan. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    // MARK: - Properties
     
  
     
     private let titleLbl: UILabel = {
         let label = UILabel()
         label.text = "Sign In with Email"
         label.font = UIFont(name: "Avenir-Light", size: 30)
         label.textColor = UIColor.black
         return label
     }()
     
      private lazy var emailContainerView1: UIView = {
           let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x"),textField: emailTextField )
           view.heightAnchor.constraint(equalToConstant: 50).isActive = true
           return view
       }()
    
    
     private lazy var passwordContainerView1: UIView = {
         let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x"),textField: passwordTextField1)
         view.heightAnchor.constraint(equalToConstant: 50).isActive = true
         return view
     }()
     
     private let emailTextField: UITextField = {
         return UITextField().textField(withPlaceholder: "Email", isSecureTextEntry: false)
     }()
     
     private let passwordTextField1: UITextField = {
         return UITextField().textField(withPlaceholder: "Password", isSecureTextEntry: true)
     }()
     
  
     
   
     override func viewDidLoad() {
         super.viewDidLoad()

         configUI()
     }
     
     // MARK: - Selectors
    
     
    
     
  
     // MARK: - Helper Function
     
     func configUI() {
         //configNavBar()
         
         view.backgroundColor = .white
     
        
         view.addSubview(titleLbl)
         titleLbl.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20)
         titleLbl.centerX(inView: view)
         
         let stack = UIStackView(arrangedSubviews: [emailContainerView1, passwordContainerView1])
         stack.axis = .vertical
         stack.distribution = .fillEqually
         stack.spacing = 20
         
         view.addSubview(stack)
         stack.anchor(top: titleLbl.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 30, paddingLeft: 16, paddingRight: 16)
     }
     
   
    }
    



