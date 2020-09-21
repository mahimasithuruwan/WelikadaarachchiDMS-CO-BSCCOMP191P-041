//
//  SurveyResultViewController.swift
//  WelikadaarachchiDMS-CO-BSCCOMP191P-041
//
//  Created by Mahima Sithuruwan on 9/13/20.
//  Copyright © 2020 Mahima Sithuruwan. All rights reserved.

import UIKit
import CoreData
import FirebaseAuth

class SurveyResultViewController: UIViewController {
    
    var result: Int?
    var people: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        self.view.backgroundColor = .black
        setupViews()
    }
    
    func showRating() {
        var rating = ""
        var color = UIColor.white
        guard let percent = result else { return }
        if percent < 5 {
            rating = "VERY LOW"
            color = UIColor.green
        } else if percent <= 25 {
            rating = "LOW"
            color = UIColor.white
        }  else if percent <= 50 {
            rating = "MEDIUM"
            color = UIColor.yellow
        } else if percent <= 75 {
            rating = "HIGH"
            color = UIColor.orange
        } else if percent <= 100 {
            rating = "VERY HIGH"
            color = UIColor.red
        }
        lblRating.text = "\(rating)"
        lblRating.textColor=color        
        surveyResultUpdate()
        saveData(rates: rating)
    }
    
    @objc func saveData(rates: String) {
        
        let rate = rates;
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext =
            appDelegate.persistentContainer.viewContext
        let entity =
            NSEntityDescription.entity(forEntityName: "SurveyResult",
                                       in: managedContext)!
        let sResult = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myString = formatter.string(from: Date())
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = "dd-MMM-yyyy"
        let myStringafd = formatter.string(from: yourDate!)
        
        sResult.setValue(rate, forKeyPath: "result")
        sResult.setValue(myStringafd, forKeyPath: "date")
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func surveyResultUpdate() {
        guard let result = result else { return }
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        let values = [
            "surveyResult": result,
            "surveyDate": [".sv": "timestamp"]
            ] as [String : Any]
        
        self.uploadSurveyResult(uid: currentUid, values: values)
    }
    
    func uploadSurveyResult(uid: String, values: [String: Any]) {
        REF_USERS.child(uid).updateChildValues(values) { (error, ref) in
            if error == nil {
                print("No error")
            }
        }
    }
    
    @objc func btnGoBackAction() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func setupViews() {
        
        self.view.addSubview(lblTitle)
        lblTitle.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80).isActive=true
        lblTitle.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive=true
        lblTitle.widthAnchor.constraint(equalToConstant: 250).isActive=true
        lblTitle.heightAnchor.constraint(equalToConstant: 80).isActive=true
        
        self.view.addSubview(lblScore)
        lblScore.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 0).isActive=true
        lblScore.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive=true
        lblScore.widthAnchor.constraint(equalToConstant: 150).isActive=true
        lblScore.heightAnchor.constraint(equalToConstant: 60).isActive=true
        lblScore.text = "\(result!)%"
        
        self.view.addSubview(lblRating)
        lblRating.topAnchor.constraint(equalTo: lblScore.bottomAnchor, constant: 40).isActive=true
        lblRating.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive=true
        lblRating.widthAnchor.constraint(equalToConstant: 150).isActive=true
        lblRating.heightAnchor.constraint(equalToConstant: 60).isActive=true
        showRating()
        
        self.view.addSubview(btnGoBack)
        btnGoBack.topAnchor.constraint(equalTo: lblRating.bottomAnchor, constant: 40).isActive=true
        btnGoBack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive=true
        btnGoBack.widthAnchor.constraint(equalToConstant: 150).isActive=true
        btnGoBack.heightAnchor.constraint(equalToConstant: 50).isActive=true
        btnGoBack.addTarget(self, action: #selector(btnGoBackAction), for: .touchUpInside)
    }
    
    let lblTitle: UILabel = {
        let lbl=UILabel()
        lbl.text="Risk Level"
        lbl.textColor=UIColor.white
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 42)
        lbl.numberOfLines=2
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    let lblScore: UILabel = {
        let lbl=UILabel()
        lbl.text="0 / 0"
        lbl.textColor=UIColor.white
        lbl.textAlignment = .center
        lbl.font = UIFont.boldSystemFont(ofSize: 24)
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    let lblRating: UILabel = {
        let lbl=UILabel()
        lbl.text="LOW"
        lbl.textColor=UIColor.white
        lbl.textAlignment = .center
        lbl.font = UIFont.boldSystemFont(ofSize: 24)
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    let btnGoBack: UIButton = {
        let btn = UIButton()
        btn.setTitle("Go Back", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .darkGray
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
}
