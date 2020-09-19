//
//  testLogIn.swift
//  WelikadaarachchiDMS-CO-BSCCOMP191P-041Tests
//
//  Created by Mahima Sithuruwan on 9/17/20.
//  Copyright © 2020 Mahima Sithuruwan. All rights reserved.
//

import Foundation
import UIKit
////import FirebaseAuth
//import MapKit
//import LocalAuthentication

class testLogIn{
    
    func validateEmail(email : String) -> Bool{
        if(email.count>0){
            return true;
        }
        else{
            return false;
            
        }
    }
//    @objc func handleSignIn(var email) {
//      //  guard let email = emailTextFiled.text else { return }
//      //  guard let password = passwordTextFiled.text else { return }
//
//        if(email.count==0){
//            let ac = UIAlertController(title: "Log In", message: "Please enter email", preferredStyle: .alert)
//            ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
//            self.present(ac, animated: true)
//            return;
//        }
//
//        if(password.count==0){
//            let ac = UIAlertController(title: "Log In", message: "Please enter passward", preferredStyle: .alert)
//            ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
//            self.present(ac, animated: true)
//            return;
//        }
//
//        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
//            if let error = error {
//                let ac = UIAlertController(title: "Log In", message: "\(error.localizedDescription)", preferredStyle: .alert)
//                ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
//                self.present(ac, animated: true)
//                print("DEBUG: Faild to log user with error \(error.localizedDescription)")
//                return
//            }
//            let keyWindow = UIApplication.shared.connectedScenes
//                .filter({$0.activationState == .foregroundActive})
//                .map({$0 as? UIWindowScene})
//                .compactMap({$0})
//                .first?.windows
//                .filter({$0.isKeyWindow}).first
//
//            guard let controller = keyWindow?.rootViewController as? MainTabBarController else { return }
//            controller.setupTabBar()
//
//
//            self.dismiss(animated: true, completion: nil)
//        }
//    }
    
}
