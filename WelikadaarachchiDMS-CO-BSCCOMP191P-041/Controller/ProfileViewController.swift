//
//  ProfileViewController.swift
//  WelikadaarachchiDMS-CO-BSCCOMP191P-041
//
//  Created by Mahima Sithuruwan on 9/15/20.
//  Copyright © 2020 Mahima Sithuruwan. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    
    // MARK: - Properties
    
    var safeArea: UILayoutGuide!
    
    var user: User? {
        didSet {
            titleLbl.text = "\(user!.firstname) \(user!.lastname)"
            firstNameTF.text = user!.firstname
            lastNameTF.text = user!.lastname
            indexTF.text = user!.index
            addressTF.text = user!.address
            tempLbl.text = "\(user!.temperature)°C"
        }
    }
    
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
        label.text = "Update Profile"
        label.font = UIFont(name: "Avenir-Light", size: 26)
        label.textColor = .white
        return label
    }()
    
    private let avatar: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "camara")
        image.layer.cornerRadius = 50;
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        image.tintColor = .white
        return image
    }()
        
    private let tempLbl: UILabel = {
        let label = UILabel()
        label.text = "0°C"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    private let firstNameTF: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.placeholder = "First Name"
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .sentences
        tf.layer.borderColor = UIColor.black.cgColor
        tf.layer.borderWidth = 0.5
        tf.layer.cornerRadius = 5.0
        tf.layer.masksToBounds = true
        return tf
    }()
    
    private let lastNameTF: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.placeholder = "Last Name"
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .sentences
        tf.layer.borderColor = UIColor.black.cgColor
        tf.layer.borderWidth = 0.5
        tf.layer.cornerRadius = 5.0
        tf.layer.masksToBounds = true
        return tf
    }()
    
    private let indexTF: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.placeholder = "Index"
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .sentences
        tf.layer.borderColor = UIColor.black.cgColor
        tf.layer.borderWidth = 0.5
        tf.layer.cornerRadius = 5.0
        tf.layer.masksToBounds = true
        return tf
    }()
    
    private let addressTF: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.placeholder = "Address"
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .sentences
        tf.layer.borderColor = UIColor.black.cgColor
        tf.layer.borderWidth = 0.5
        tf.layer.cornerRadius = 5.0
        tf.layer.masksToBounds = true
        return tf
    }()
    
    
    
    private let updateButton: UIButton = {
        let button = UIButton()
        // button.backgroundColor = .white
        button.backgroundColor = .darkGray
        button.setTitle("UPDATE", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 14)
        button.addTextSpacing(2)
        button.addTarget(self, action: #selector(handleUpdate), for: .touchUpInside)
        return button
    }()
    
    
    private lazy var mainTile: UIView = {
        let tile = UIView()
        //tile.backgroundColor = .white
        tile.backgroundColor = .black
        
        tile.addSubview(updateButton)
        updateButton.anchor(left: tile.leftAnchor, bottom: tile.bottomAnchor, right: tile.rightAnchor, height: 60)
        
        let separatorView = UIView()
        separatorView.backgroundColor = .lightGray
        tile.addSubview(separatorView)
        separatorView.anchor(left: tile.leftAnchor, bottom: updateButton.topAnchor, right: tile.rightAnchor, paddingLeft: 8, paddingRight: 8, height: 0.75)
        
        tile.addSubview(avatar)
        avatar.anchor(top: tile.topAnchor, paddingTop: 30, width: 100, height: 100)
        avatar.centerX(inView: tile)
        
        tile.addSubview(tempLbl)
        tempLbl.anchor(top: avatar.bottomAnchor, left: tile.leftAnchor, right: tile.rightAnchor, paddingTop: 10, paddingLeft: 70, paddingRight: 70)
        tempLbl.centerX(inView: tile)
        
        let stack = UIStackView(arrangedSubviews: [firstNameTF, lastNameTF, indexTF, addressTF])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 30
        tile.addSubview(stack)
        stack.anchor(top: tempLbl.bottomAnchor, left: tile.leftAnchor, right: tile.rightAnchor, paddingTop: 40, paddingLeft: 16, paddingRight: 16)
        
        return tile
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        safeArea = view.layoutMarginsGuide
        fetchUserData()
        configUI()
        self.hideKeyboardWhenTappedAround()
    }
    
    // MARK: - Selectors
    
    @objc func handleGoBack() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func handleUpdate() {
        guard let firstName = firstNameTF.text else { return }
        guard let lastName = lastNameTF.text else { return }
        guard let index = indexTF.text else { return }
        guard let address = addressTF.text else { return }
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        if firstName.isEmpty {
            let alert = UIAlertController(title: "First Name is Required!", message: "Please enter your lirst Name", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        } else if lastName.isEmpty  {
            let alert = UIAlertController(title: "Last Name is Required!", message: "Please enter your Last Name", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        } else if index.isEmpty  {
            let alert = UIAlertController(title: "Index is Required!", message: "Please enter your Index No", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        } else if address.isEmpty  {
            let alert = UIAlertController(title: "Address is Required!", message: "Please enter your Address", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        self.view.endEditing(true)
        let values = [
            "firstName": firstName,
            "lastName": lastName,
            "index": index,
            "address": address,
            "profileDate": [".sv": "timestamp"]
            ] as [String : Any]
        self.uploadUserProfile(uid: currentUid, values: values)
        
    }
    
    func configUI() {
        configNavBar()
        // view.backgroundColor = .white
        view.backgroundColor = .black
        view.addSubview(titleLbl)
        titleLbl.anchor(top: safeArea.topAnchor, paddingTop: 20)
        titleLbl.centerX(inView: view)
        view.addSubview(backButton)
        backButton.anchor(top: safeArea.topAnchor, left: view.leftAnchor, paddingTop: 20, paddingLeft: 16, width: 38, height: 38)
        view.addSubview(mainTile)
        mainTile.anchor(top: titleLbl.bottomAnchor, left: view.leftAnchor, bottom: safeArea.bottomAnchor, right: view.rightAnchor, paddingTop: 20)
    }
    
    func configNavBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .default
    }
    
    // MARK: - API
    
    func fetchUserData() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        Service.shared.fetchUserData(uid: currentUid) { (user) in
            self.user = user
        }
    }
    
    func uploadUserProfile(uid: String, values: [String: Any]) {
        REF_USERS.child(uid).updateChildValues(values) { (error, ref) in
            if error == nil {
                let alert = UIAlertController(title: "Success!", message: "Profile updated sucessfully", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }
    
}
