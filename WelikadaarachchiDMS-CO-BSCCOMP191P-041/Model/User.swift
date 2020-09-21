//
//  User.swift
//  WelikadaarachchiDMS-CO-BSCCOMP191P-041
//
//  Created by Mahima Sithuruwan on 9/11/20.
//  Copyright © 2020 Mahima Sithuruwan. All rights reserved.
//

import CoreLocation


struct User {
    let firstname: String
    let lastname: String
    var email: String
    var role: String
    var location: CLLocation?
    let temperature: String
    let uid: String
    var surveyResult: Int
    let index: String
    let address: String
    
    init(uid: String, dictionary: [String: Any]) {
        self.uid = uid
        self.firstname = dictionary["firstname"] as? String ?? ""
        self.lastname = dictionary["lastname"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.role = dictionary["role"] as? String ?? ""
        self.temperature = dictionary["temperature"] as? String ?? "0"
        self.surveyResult = dictionary["surveyResult"] as? Int ?? 0
        self.index = dictionary["index"] as? String ?? ""
        self.address = dictionary["address"] as? String ?? ""
        
        
    }
}
