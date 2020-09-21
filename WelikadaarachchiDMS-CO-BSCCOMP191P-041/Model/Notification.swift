//
//  Notification.swift
//  WelikadaarachchiDMS-CO-BSCCOMP191P-041
//
//  Created by Mahima Sithuruwan on 9/20/20.
//  Copyright © 2020 Mahima Sithuruwan. All rights reserved.
//


struct Notification {
    let id: String
    let title: String
    let description: String
    let date: Int
    
    init(id: String, dictionary: [String: Any]) {
        self.id = id
        self.title = dictionary["title"] as? String ?? ""
        self.description = dictionary["description"] as? String ?? ""
        self.date = dictionary["email"] as? Int ?? 0
    }
}
