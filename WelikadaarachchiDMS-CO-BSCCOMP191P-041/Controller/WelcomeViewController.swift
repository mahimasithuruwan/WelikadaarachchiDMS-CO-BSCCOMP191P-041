//
//  WelcomeViewController.swift
//  WelikadaarachchiDMS-CO-BSCCOMP191P-041
//
//  Created by Mahima Sithuruwan on 9/11/20.
//  Copyright © 2020 Mahima Sithuruwan. All rights reserved.


import UIKit

class WelcomeViewController: UIViewController {

  // MARK: - Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        //label.textColor = UIColor.black
        label.text = "NIBM"
        label.font = UIFont(name: "Avenir-Light", size: 36)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var WelcomeImgView: UIImageView = {
        let imageview = UIImageView()
        imageview.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        imageview.image = UIImage(named:"corona_virus_logo")
        imageview.layer.masksToBounds = true
        imageview.contentMode = .scaleAspectFit
       //view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return imageview
        
    }()
    
    private let regPageButton: AuthUIBtn = {
        let button = AuthUIBtn(type: .system)
        button.setTitle("Create an Account", for: .normal)
        button.titleLabel?.font=UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)
        button.addTarget(self, action: #selector(showRegPage), for: .touchUpInside)
        
        return button
    } ()
    
    
    private let loginPageButton: UIButton = {
        let button = UIButton(type: .system)
        let buttonTitle = NSMutableAttributedString(string: "Already have an account?", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white])
        button.addTarget(self, action: #selector(showLoginPage), for: .touchUpInside)
        button.setAttributedTitle(buttonTitle, for: .normal)
        
        return button
    }()
    
    private let termsAndConBtn: UIButton = {
        let button = UIButton(type: .system)
        let attributedText = NSMutableAttributedString(string: "By signing up, you agree with the ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        attributedText.append(NSAttributedString(string: "Terms of Service", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.mainBlueTint]))
        attributedText.append(NSAttributedString(string: " and ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.gray]))
        attributedText.append(NSAttributedString(string: "Privacy Policy.", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.mainBlueTint]))
        
        button.addTarget(self, action: #selector(showRegPage), for: .touchUpInside)
        button.setAttributedTitle(attributedText, for: .normal)
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        button.titleLabel?.textAlignment = NSTextAlignment.center
        
        return button
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
        
        view.backgroundColor = .black
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20)
        titleLabel.centerX(inView: view)
        
        view.addSubview(WelcomeImgView)
        WelcomeImgView.anchor(top: titleLabel.bottomAnchor, paddingTop: 100, width: 300, height: 157)
        WelcomeImgView.centerX(inView: view)
        
        let stack = UIStackView(arrangedSubviews: [regPageButton, loginPageButton])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 24

        view.addSubview(stack)
        stack.anchor(top: WelcomeImgView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 100, paddingLeft: 16, paddingRight: 16)

//        view.addSubview(stack)
//        stack.anchor(top: WelcomeImgView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingRight: 16)
//
//        view.addSubview(termsAndConBtn)
//        termsAndConBtn.centerX(inView: view)
//        termsAndConBtn.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right:  view.rightAnchor, paddingLeft: 16, paddingBottom:16, paddingRight: 16, height: 50)
    }
    
    
    
        func configNavBar(){
            navigationController?.navigationBar.isHidden = true
            navigationController?.navigationBar.barStyle = .default
        }
        
        
     

    }

    
    
           
             



