//
//  SplashScreenViewController.swift
//  WelikadaarachchiDMS-CO-BSCCOMP191P-041
//
//  Created by Mahima Sithuruwan on 9/11/20.
//  Copyright © 2020 Mahima Sithuruwan. All rights reserved.


import UIKit

class SplashScreenViewController: UIViewController {

     private let titleLabel: UILabel = {
         let label = UILabel()
         label.text = "CREATE"
         label.font = UIFont(name: "Avenir-Light", size: 36)
         label.textColor = .black
       
         
         return label
     }()
    
    private let notificationabel: UILabel = {
          let label = UILabel()
          label.text = "Create Notifications"
          label.font = UIFont(name: "Avenir-Light", size: 15)
          label.textColor = .black
         label.backgroundColor = .blue
          
          return label
      }()
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()

        // Do any additional setup after loading the view.s
    }
    
    private let notificationTextFiled: UITextField = {
       return UITextField().textField(withPlaceholder: "Create Notifications", isSecureTextEntry: false)
    }()
    func configureUI() {
          view.backgroundColor = .whiteBackground
             
             view.addSubview(titleLabel)
             titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor)
             titleLabel.centerX(inView: view)
             
             let stack = UIStackView(arrangedSubviews: [notificationabel])
             stack.axis = .vertical
             stack.distribution = .fillProportionally
             stack.spacing = 24
             
             view.addSubview(stack)
             stack.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 16, paddingRight: 16)
             
         }
   

}
