//
//  FViewController.swift
//  WelikadaarachchiDMS-CO-BSCCOMP191P-041
//
//  Created by Mahima Sithuruwan on 9/19/20.
//  Copyright © 2020 Mahima Sithuruwan. All rights reserved.
//

import UIKit
import FirebaseAuth
import MapKit
import LocalAuthentication

class FViewController: UIViewController {
    
    // MARK: - Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "NIBM"
        label.font = UIFont(name: "Avenir-Light", size: 36)
        label.textColor = UIColor(white: 1, alpha: 0.8)
        
        return label
    }()
    
    private lazy var emailContainerView: UIView = {
        let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x"), textField: emailTextFiled)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private let emailTextFiled: UITextField = {
        let email = UITextField().textField(withPlaceholder: "Email", isSecureTextEntry: false)
        email.textColor = .white
        return email
    }()
    
    private let loginButton: AuthUIBtn = {
        let button = AuthUIBtn(type: .system)
        button.setTitle("Reset", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Lifecycale
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //NawBar
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Videos"
        
        configureUI()
    }
    
    
    // MARK: - Selectors
    
    @objc func handleSignIn() {
        guard let email = emailTextFiled.text else { return }
        
        if(email.count==0){
            let ac = UIAlertController(title: "Log In", message: "Please enter email", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
            self.present(ac, animated: true)
            return;
        }
        
        if(!email.contains("@") || !email.contains(".")){
            let ac = UIAlertController(title: "Log In", message: "Please enter email correctly", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
            self.present(ac, animated: true)
            return;
        }
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
           
            if error != nil {
                let ac = UIAlertController(title: "Reset UserName", message: error!.localizedDescription, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
                self.present(ac, animated: true)
            }
            else{
                let ac = UIAlertController(title: "Reset UserName", message: "Successfull ! , Please check your mail", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
                self.present(ac, animated: true)

                let nav = UINavigationController(rootViewController: LoginViewController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        }
        
    }
    
    @objc func handleShowRegister() {
        let vc = RegisterViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func handleShowLogIn() {
        let lc = LoginViewController()
        navigationController?.pushViewController(lc, animated: true)
    }
    
    
    // MARK: - Helper Function
    
    func configureUI() {
        
        configureNavigationBar()
        
        view.backgroundColor = .black
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor)
        titleLabel.centerX(inView: view)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, loginButton])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 24
        
        view.addSubview(stack)
        stack.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 16, paddingRight: 16)
        
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
    
    
    
    
    
    
}
