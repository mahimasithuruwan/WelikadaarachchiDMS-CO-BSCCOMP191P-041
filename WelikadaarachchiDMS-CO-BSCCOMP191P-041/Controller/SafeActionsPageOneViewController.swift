//
//  SafeActionsPageOneViewController.swift
//  WelikadaarachchiDMS-CO-BSCCOMP191P-041
//
//  Created by Mahima Sithuruwan on 9/13/20.
//  Copyright © 2020 Mahima Sithuruwan. All rights reserved.

import UIKit

class SafeActionsPageOneViewController: UIViewController {
    
    // MARK: - Properties
    
    private let backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "back-img"), for: .normal)
        button.addTarget(self, action: #selector(handleGoBack), for: .touchUpInside)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Safe Actions"
        label.font=UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
        label.textColor = .black
        
        return label
    }()
    
    private lazy var WelcomeImgView: UIImageView = {
        let imageview = UIImageView()
        imageview.frame = CGRect(x: 0, y: 0, width: 439, height:500)
        imageview.image = UIImage(named:"safe-actions-1")
        imageview.layer.masksToBounds = true
        return imageview
        
    }()
    
    private let warningLabel: UILabel = {
        let warningLabel = UILabel()
        warningLabel.text = "Clean yourself"
        warningLabel.font=UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
        warningLabel.textColor = .black
        
        return warningLabel
    }()
    
    private let questionOneLabel: UILabel = {
        let questionOneLabel = UILabel()
        questionOneLabel.text = "When and how to wash your hands"
        questionOneLabel.font = UIFont(name: "Avenir-Light", size: 18)
        questionOneLabel.textColor = .black
        return questionOneLabel
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Next", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold), NSAttributedString.Key.foregroundColor: UIColor.mainBlueTint])
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()    
    
    // MARK: - Lifecycale
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    @objc func handleGoBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleNext() {
        let vc = SafeActionsPageTwoViewController()
        navigationController?.pushViewController(vc, animated: false)
    }
    
    
    //MARk:- helper Function
    func configUI(){
        configNavBar()
        
        view.backgroundColor = .white
        
        
        view.addSubview(backButton)
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 10, paddingLeft: 16, width: 40, height: 40)
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20)
        titleLabel.centerX(inView: view)
        
        view.addSubview(WelcomeImgView)
        WelcomeImgView.anchor(top: titleLabel.bottomAnchor, paddingTop: 50, width: 300, height: 270)
        WelcomeImgView.centerX(inView: view)

        view.addSubview(warningLabel)
        warningLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 380)
        warningLabel.centerX(inView: view)

        view.addSubview(questionOneLabel)
        questionOneLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 410)
        questionOneLabel.centerX(inView: view)
        view.addSubview(nextButton)
        nextButton.centerX(inView: view)
        nextButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 550)
    }
    
    
    func configNavBar(){
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .default
    }
    
    
    
    
    
}
