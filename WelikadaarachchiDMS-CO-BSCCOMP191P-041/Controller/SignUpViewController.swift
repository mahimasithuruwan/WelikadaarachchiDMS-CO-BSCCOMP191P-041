//
//  SignUpViewController.swift
//  WelikadaarachchiDMS-CO-BSCCOMP191P-041
//
//  Created by Mahima Sithuruwan on 9/10/20.
//  Copyright © 2020 Mahima Sithuruwan. All rights reserved.
//

import UIKit
import FirebaseAuth
import GeoFire

class SignUpViewController: UIViewController {
    
     // MARK: - Properties
    
       private var location = LocationHandler.shared.locationManager.location

       private let titleLabel: UILabel = {
           let label = UILabel()
           label.text = "NIBM"
           label.font = UIFont(name: "Avenir-Light", size: 36)
           label.textColor = UIColor(white: 1, alpha: 0.8)
           
           return label
       }()
       
      
       private lazy var firstNameContainerView: UIView = {
           let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: firstNameTextFiled )
           view.heightAnchor.constraint(equalToConstant: 50).isActive = true
           return view
       }()
    
      private lazy var lastNameContainerView: UIView = {
              let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: lastTextFiled )
              view.heightAnchor.constraint(equalToConstant: 50).isActive = true
              return view
          }()
          
      private lazy var emailContainerView: UIView = {
        let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x") , textField: emailTextFiled )
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
      }()
    
    private lazy var accountTypeContainerView: UIView = {
        let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_account_box_white_2x"), segentedControl: accountTypeSegmentedControl)
        view.heightAnchor.constraint(equalToConstant: 80).isActive = true
        return view
    }()
    
       private lazy var passwordContainerView: UIView = {
           let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: passwordTextFiled)
           view.heightAnchor.constraint(equalToConstant: 50).isActive = true
           return view
       }()
    
    
       private let firstNameTextFiled: UITextField = {
         let firstName = UITextField().textField(withPlaceholder: "First Name", isSecureTextEntry: false)
         firstName.textColor = .white
         return firstName
       }()
      
       private let lastTextFiled: UITextField = {
         let lastName =  UITextField().textField(withPlaceholder: "Last Name", isSecureTextEntry: false)
         lastName.textColor = .white
         return lastName
       }()
        
       private let emailTextFiled: UITextField = {
         let email = UITextField().textField(withPlaceholder: "Email", isSecureTextEntry: false)
         email.textColor = .white
         return email
       }()
    
     
       private let accountTypeSegmentedControl: UISegmentedControl = {
           let sc = UISegmentedControl(items: ["Student","Staff"])
           sc.backgroundColor = .backgroundColor
           sc.tintColor = UIColor(white: 1, alpha: 0.87)
           sc.selectedSegmentIndex = 0
           
           return sc
       }()
       
       private let passwordTextFiled: UITextField = {
           let passward = UITextField().textField(withPlaceholder: "Password", isSecureTextEntry: true)
           passward.textColor = .white
           return passward
       }()
    
       private let signUpButton: AuthUIBtn = {
           let button = AuthUIBtn(type: .system)
           button.setTitle("Register", for: .normal)
           button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
           button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
           return button
       }()
       
       let alreadyHaveAccountButton: UIButton = {
           let button = UIButton(type: .system)
           let attributedTitle = NSMutableAttributedString(string: "Already have an account?  ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
           
           attributedTitle.append(NSAttributedString(string: "Log In", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.mainBlueTint]))
           
           button.addTarget(self, action: #selector(handleShowLogIn), for: .touchUpInside)
           
           button.setAttributedTitle(attributedTitle, for: .normal)
           return button
       }()
       
       // MARK: - Lifecycale
       
       override func viewDidLoad() {
           super.viewDidLoad()
        
        //NawBar
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "reg"
           
           configureUI()
           
       }
       
       // MARK: - Helper Function
       
       func uploadUserDataAndShowHomeController(uid: String, values: [String: Any]) {
           REF_USERS.child(uid).updateChildValues(values) { (error, ref) in

               //handle error
               let keyWindow = UIApplication.shared.connectedScenes
               .filter({$0.activationState == .foregroundActive})
               .map({$0 as? UIWindowScene})
               .compactMap({$0})
               .first?.windows
               .filter({$0.isKeyWindow}).first
            guard let controller = keyWindow?.rootViewController as? TabBarController else { return }
            controller.setupTabBar()

               self.dismiss(animated: true, completion: nil)
           }
       }
       
       func configureUI() {
        view.backgroundColor = .black
           
           view.addSubview(titleLabel)
           titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor)
           titleLabel.centerX(inView: view)
           
           let stack = UIStackView(arrangedSubviews: [firstNameContainerView, lastNameContainerView, emailContainerView, accountTypeContainerView, passwordContainerView, signUpButton])
           stack.axis = .vertical
           stack.distribution = .fillProportionally
           stack.spacing = 24
           
           view.addSubview(stack)
           stack.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 16, paddingRight: 16)
           
           view.addSubview(alreadyHaveAccountButton)
           alreadyHaveAccountButton.centerX(inView: view)
           alreadyHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, height: 32)
           
       }
       
       // MARK: - Selectors
       
       @objc func handleSignUp() {
           guard let firstname = firstNameTextFiled.text else { return }
           guard let lastname = lastTextFiled.text else { return }
           guard let email = emailTextFiled.text else { return }
           let role = accountTypeSegmentedControl.selectedSegmentIndex
           guard let password = passwordTextFiled.text else { return }
        
        if(firstname.count==0){
             let ac = UIAlertController(title: "Sign Up", message: "Please Enter First Name", preferredStyle: .alert)
             ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
             self.present(ac, animated: true)
             return;
          }
                
        if firstname.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil {
            let ac = UIAlertController(title: "Sign Up", message: "Please Enter Letters Only", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
            self.present(ac, animated: true)
            return;
        }
                      
         if(lastname.count==0){
             let ac = UIAlertController(title: "Sign Up", message: "Please Enter Last Name", preferredStyle: .alert)
             ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
             self.present(ac, animated: true)
             return;
        }
        
         if lastname.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil {
            let ac = UIAlertController(title: "Sign Up", message: "Please Enter Letters Only", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
            self.present(ac, animated: true)
            return;
        }
        
          if(email.count==0){
             let ac = UIAlertController(title: "Sign Up", message: "Please Enter Email", preferredStyle: .alert)
             ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
             self.present(ac, animated: true)
             return;
        }
        
          if(!email.contains("@") || !email.contains(".")){
             let ac = UIAlertController(title: "Log In", message: "Please Enter Email Correctly",  preferredStyle: .alert)
             ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
             self.present(ac, animated: true)
             return;
         }
        
          if(password.count==0){
             let ac = UIAlertController(title: "Sign Up", message: "Please Enter Passward", preferredStyle: .alert)
             ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
             self.present(ac, animated: true)
             return;
          }
        
          if(password.count<6){
            let ac = UIAlertController(title: "Sign Up", message: "Password should contain least 6 charactors", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
            self.present(ac, animated: true)
            return;
          }
        

           Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
               if let error = error {
                let ac = UIAlertController(title: "Sign Up", message: "\(error.localizedDescription)", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
                self.present(ac, animated: true)
                print("Faild to register user with error \(error.localizedDescription)")
                   return
               }

               guard let uid = result?.user.uid else { return }

               let values = [
                "firstname": firstname,
                "lastname": lastname,
               "email": email,
               "role":  String(role)
               ] as [String : Any]

             Database.database().reference().child("users").child(uid).updateChildValues(values) { (error, ref) in
                           print("Successfuly Registerd and save data..")
                       }
            
              
                   let geoFire = GeoFire(firebaseRef: REF_USER_LOCATIONS)

                   guard let location = self.location else { return }

                   geoFire.setLocation(location, forKey: uid, withCompletionBlock: { (error) in
                       self.uploadUserDataAndShowHomeController(uid: uid, values: values)
                   })
            

               self.uploadUserDataAndShowHomeController(uid: uid, values: values)
           }
       }
       
       @objc func handleShowLogIn() {
           navigationController?.popViewController(animated: true)
       }
}
