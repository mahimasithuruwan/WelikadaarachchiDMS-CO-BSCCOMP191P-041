//
//  DropViewController.swift
//  WelikadaarachchiDMS-CO-BSCCOMP191P-041
//
//  Created by Mahima Sithuruwan on 9/17/20.
//  Copyright © 2020 Mahima Sithuruwan. All rights reserved.
//

import UIKit

class DropViewController: UIViewController {
    
     var safeArea: UILayoutGuide!
    
    // MARK: - Properties
        private let titleLabel: UILabel = {
            let label = UILabel()
            //label.textColor = UIColor.black
            label.text = "CORONA"
            label.font = UIFont(name: "Avenir-Light", size: 36)
            //label.textColor = .black
            
            return label
        }()
        
        private lazy var WelcomeImgView: UIImageView = {
            let imageview = UIImageView()
            imageview.frame = CGRect(x: 0, y: 0, width: 100, height:100)
            imageview.image = UIImage(named:"camara")
            imageview.layer.masksToBounds = true
            
           // view.heightAnchor.constraint(equalToConstant: 50).isActive = true
            return imageview
            
        }()
    
        private lazy var profileContainerView: UIView = {
              let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x"), textField: nameTextFiled)
              view.heightAnchor.constraint(equalToConstant: 50).isActive = true
              return view
        }()
          
          private let nameTextFiled: UITextField = {
              return UITextField().textField(withPlaceholder: "name", isSecureTextEntry: false)
          }()
    

             


        
        // MARK: - Lifecycale
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            configUI()
        }
        
        @objc func showRegPage() {
            let vc = RegisterViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
        @objc func showLoginPage() {
              let vc = LoginViewController()
              navigationController?.pushViewController(vc, animated: true)
          }
            
             
        
        
         //MARk:- helper Function
        func configUI(){
            configNavBar()
            

            view.backgroundColor = .green
            view.addSubview(titleLabel)
            titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20)
            titleLabel.centerX(inView: view)



            view.addSubview(WelcomeImgView)
            WelcomeImgView.anchor(top: titleLabel.bottomAnchor, paddingTop: 100, width: 200, height: 170)
            WelcomeImgView.centerX(inView: view)

            let stack = UIStackView(arrangedSubviews: [profileContainerView])
            stack.axis = .vertical
            stack.distribution = .fillEqually
            stack.spacing = 24

            view.addSubview(stack)
            stack.anchor(top: WelcomeImgView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 100, paddingLeft: 10, paddingRight: 10)


        }
        
        
        
            func configNavBar(){
                navigationController?.navigationBar.isHidden = true
                navigationController?.navigationBar.barStyle = .default
            }
            
            
    

}
