//
//  LoginViewController.swift
//  WelikadaarachchiDMS-CO-BSCCOMP191P-041
//
//  Created by Mahima Sithuruwan on 9/10/20.
//  Copyright © 2020 Mahima Sithuruwan. All rights reserved.
//


import UIKit
import FirebaseAuth
import MapKit
import LocalAuthentication

class LoginViewController: UIViewController {
    
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
    
    private lazy var passwordContainerView: UIView = {
        let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: passwordTextFiled)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private let emailTextFiled: UITextField = {
        let email = UITextField().textField(withPlaceholder: "Email", isSecureTextEntry: false)
        email.textColor = .white
        return email
    }()
    
    private let passwordTextFiled: UITextField = {
        let passward = UITextField().textField(withPlaceholder: "Password", isSecureTextEntry: true)
        passward.textColor = .white
        return passward
    }()
    
    private let loginButton: AuthUIBtn = {
        let button = AuthUIBtn(type: .system)
        button.setTitle("Log In", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        return button
    }()
    
    let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account?  ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        attributedTitle.append(NSAttributedString(string: "Register", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.mainBlueTint]))
        
        button.addTarget(self, action: #selector(handleShowRegister), for: .touchUpInside)
        
        button.setAttributedTitle(attributedTitle, for: .normal)
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
           guard let password = passwordTextFiled.text else { return }
        
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

        if(password.count==0){
                let ac = UIAlertController(title: "Log In", message: "Please enter password", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
                self.present(ac, animated: true)
                return;
        }
        
           Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
               if let error = error {
                   let ac = UIAlertController(title: "Log In", message: "\(error.localizedDescription)", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
                   self.present(ac, animated: true)
                   print("DEBUG: Faild to log user with error \(error.localizedDescription)")
                   return
               }
            self.faceID()
               let keyWindow = UIApplication.shared.connectedScenes
               .filter({$0.activationState == .foregroundActive})
               .map({$0 as? UIWindowScene})
               .compactMap({$0})
               .first?.windows
               .filter({$0.isKeyWindow}).first
               
             guard let controller = keyWindow?.rootViewController as? MainTabBarController else { return }
               controller.setupTabBar()

               
               self.dismiss(animated: true, completion: nil)
           }
       }
    
    // MARK:- FaceID
    
    func faceID(){
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [weak self] success, authenticationError in
                
                DispatchQueue.main.async {
                    if success {
                        let ac = UIAlertController(title: "Authentication success", message: "Well Done", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "Happy", style: .default))
                        self?.present(ac, animated: true)
                    } else {
                        let ac = UIAlertController(title: "Authentication failed", message: "You could not be verified; please try again.", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        self?.signOut()
                        //  self?.present(ac, animated: true)
                        self?.dismiss(animated: true, completion: nil)
                        
                    }
                }
            }
        }
        else {
            let ac = UIAlertController(title: "Biometry unavailable", message: "Your device is not configured for biometric authentication.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginViewController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } catch {
            print("DEBUG: sign out error")
        }
    }
    
    @objc func handleShowRegister() {
        let vc = RegisterViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Helper Function
    
    func configureUI() {
        
        configureNavigationBar()
        
        view.backgroundColor = .black
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor)
        titleLabel.centerX(inView: view)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButton])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 24
        
        view.addSubview(stack)
        stack.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.centerX(inView: view)
        dontHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, height: 32)
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }


    

  

}
