//
//  test.swift
//  WelikadaarachchiDMS-CO-BSCCOMP191P-041
//
//  Created by Mahima Sithuruwan on 9/20/20.
//  Copyright © 2020 Mahima Sithuruwan. All rights reserved.
//

import UIKit

class ContactUsVjhjiewController: UIViewController {
    
    var safeArea: UILayoutGuide!
    
    private let topNav: UIView = {
        let uv = UIView()
        //uv.backgroundColor = .systemGray6
        uv.backgroundColor = .updatepagecolor
        
        let backBtn = UIButton()
        let boldConfig = UIImage.SymbolConfiguration(pointSize: .zero, weight: .bold, scale: .large)
        backBtn.setImage(UIImage(systemName: "chevron.left", withConfiguration: boldConfig), for: .normal)
        backBtn.tintColor = .black
        backBtn.addTarget(self, action: #selector(handleGoBack), for: .touchUpInside)
        uv.addSubview(backBtn)
        backBtn.anchor(left: uv.leftAnchor, paddingLeft: 16, width: 38, height: 38)
        backBtn.centerY(inView: uv)
        
        let titleLbl = UILabel()
        titleLbl.text = "Contact Us / About Us"
        titleLbl.font = UIFont(name: "Avenir-Light", size: 26)
        titleLbl.textColor = .black
        titleLbl.adjustsFontSizeToFitWidth = true
        uv.addSubview(titleLbl)
        titleLbl.centerY(inView: uv)
        titleLbl.centerX(inView: uv)
        
        return uv
    }()
    
    private let titleTF: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.placeholder = "Email"
        tf.setDimensions(height: 50, width: 10)
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .sentences
        tf.layer.borderColor = UIColor.black.cgColor
        tf.layer.borderWidth = 0.5
        tf.layer.cornerRadius = 5.0
        tf.layer.masksToBounds = true
        return tf
        
        
    }()
    
    private let subject: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.placeholder = "Subject"
        tf.setDimensions(height: 50, width: 10)
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .sentences
        tf.layer.borderColor = UIColor.black.cgColor
        tf.layer.borderWidth = 0.5
        tf.layer.cornerRadius = 5.0
        tf.layer.masksToBounds = true
        return tf
        
        
    }()
    
    private let descriptionTF: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.placeholder = "Description"
        tf.setDimensions(height: 150, width: 10)
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .sentences
        tf.layer.borderColor = UIColor.black.cgColor
        tf.layer.borderWidth = 0.5
        tf.layer.cornerRadius = 5.0
        tf.layer.masksToBounds = true
        return tf
        
    }()
    
    private let createBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Contact Us", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .mainBlueTint
        btn.layer.cornerRadius = 5.0
        btn.layer.masksToBounds = true
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.addTextSpacing(2)
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        // btn.addTarget(self, action: #selector(handleCreate), for: .touchUpInside)
        return btn
    }()
    
    private lazy var formTile: UIView = {
        let tile = UIView()
        // tile.backgroundColor = .white
        tile.backgroundColor = .updatetilecolor
        
        
        let stack = UIStackView(arrangedSubviews: [titleTF, subject, descriptionTF, createBtn])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 30
        
        
        tile.addSubview(stack)
        stack.anchor(top: tile.topAnchor, left: tile.leftAnchor, right: tile.rightAnchor, paddingTop: 40, paddingLeft: 16, paddingRight: 16)
        
        
        
        return tile
    }()
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        safeArea = view.layoutMarginsGuide
        self.configUI()
        self.hideKeyboardWhenTappedAround()
    }
    
    // MARK: - Selectors
    
    @objc func handleGoBack() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    
    // MARK: - Helper Functions
    
    func configUI() {
        // view.backgroundColor = .systemGray6
        view.backgroundColor = .updatepagecolor
        configNavBar()
        view.addSubview(topNav)
        topNav.anchor(top: safeArea.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: view.bounds.height * 0.1)
        view.addSubview(formTile)
        formTile.anchor(top: topNav.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
    
    func configNavBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .default
    }
    
    func uploadNotificationData(uid: String, values: [String: Any]) {
        
        REF_NOTIFICATIONS.childByAutoId().setValue(values) { (error, ref) in
            
            if let error = error {
                print("Faild to create notification \(error)")
                return
            }
            
            let alert = UIAlertController(title: "Success!", message: "Notification created successfully", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            
        }
        
    }
}
