//
//  ContactViewController.swift
//  WelikadaarachchiDMS-CO-BSCCOMP191P-041
//
//  Created by Mahima Sithuruwan on 9/15/20.
//  Copyright © 2020 Mahima Sithuruwan. All rights reserved.
//

import UIKit

class ContactUsViewController: UIViewController {
    
    // MARK: - Properties
    
    var safeArea: UILayoutGuide!
    
    private let backButton: UIButton = {
        let button = UIButton(type: .custom)
        let boldConfig = UIImage.SymbolConfiguration(pointSize: .zero, weight: .bold, scale: .large)
        button.setImage(UIImage(systemName: "chevron.left", withConfiguration: boldConfig), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleGoBack), for: .touchUpInside)
        return button
    }()
    
    private let titleLbl: UILabel = {
        let label = UILabel()
        label.text = "Contact Us"
        label.font = UIFont(name: "Avenir-Light", size: 26)
        label.textColor = .white
        return label
    }()
    private let tempLbl: UILabel = {
        let label = UILabel()
        label.text = "Call Us"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    private let temp2Lbl: UILabel = {
        let label = UILabel()
        label.text = "011-2258112"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    private let emailLbl: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    private let email2Lbl: UILabel = {
        let label = UILabel()
        label.text = "covid19@nibm.lk"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    private lazy var blankView: UIView = {
        let blank = UIView()
        blank.backgroundColor = .black
        
        blank.addSubview(tempLbl)
        tempLbl.anchor(top: blank.bottomAnchor, left: blank.leftAnchor, right: blank.rightAnchor, paddingTop: 10, paddingLeft: 70, paddingRight: 70)
        tempLbl.centerX(inView: blank)
        
        blank.addSubview(temp2Lbl)
        temp2Lbl.anchor(top: tempLbl.bottomAnchor, left: blank.leftAnchor, right: blank.rightAnchor, paddingTop: 10, paddingLeft: 70, paddingRight: 70)
        temp2Lbl.centerX(inView: blank)
        
        blank.addSubview(emailLbl)
        emailLbl.anchor(top: temp2Lbl.bottomAnchor, left: blank.leftAnchor, right: blank.rightAnchor, paddingTop: 10, paddingLeft: 70, paddingRight: 70)
        emailLbl.centerX(inView: blank)
        
        blank.addSubview(email2Lbl)
        email2Lbl.anchor(top: emailLbl.bottomAnchor, left: blank.leftAnchor, right: blank.rightAnchor, paddingTop: 10, paddingLeft: 70, paddingRight: 70)
        email2Lbl.centerX(inView: blank)
        
        return blank
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        safeArea = view.layoutMarginsGuide
        configUI()
    }
    
    // MARK: - Selectors
    
    @objc func handleGoBack() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func configUI() {
        configNavBar()
        view.backgroundColor = .black
        
        view.addSubview(titleLbl)
        titleLbl.anchor(top: safeArea.topAnchor, paddingTop: 20)
        titleLbl.centerX(inView: view)
        view.addSubview(backButton)
        backButton.anchor(top: safeArea.topAnchor, left: view.leftAnchor, paddingTop: 20, paddingLeft: 16, width: 38, height: 38)
        view.addSubview(blankView)
        blankView.anchor(top: titleLbl.bottomAnchor , left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20)
    }
    
    func configNavBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .default
    }
    
}
