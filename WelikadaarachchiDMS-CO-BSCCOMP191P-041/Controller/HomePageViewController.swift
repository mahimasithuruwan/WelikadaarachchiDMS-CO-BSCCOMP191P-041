//
//  HomePageViewController.swift
//  WelikadaarachchiDMS-CO-BSCCOMP191P-041
//
//  Created by Mahima Sithuruwan on 9/15/20.
//  Copyright © 2020 Mahima Sithuruwan. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController {
    
    
       private let notificationsTile: UIButton = {
           let tileView = UIButton()
           tileView.backgroundColor = .white
           tileView.layer.cornerRadius = 5
           tileView.layer.masksToBounds = true
          // tileView.addTarget(self, action: #selector(showNotifications), for: .touchUpInside)
           return tileView
       }()
       
       private let notificationsTileLabel: UILabel = {
           let label = UILabel()
           label.text = "Create Notifications"
           label.font = UIFont(name: "Avenir-Medium", size: 18)
           label.textColor = UIColor.black
           //label.backgroundColor = .red
           return label
       }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

  
}
