//
//  TabBarController.swift
//  WelikadaarachchiDMS-CO-BSCCOMP191P-041
//
//  Created by Mahima Sithuruwan on 9/11/20.
//  Copyright © 2020 Mahima Sithuruwan. All rights reserved.

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //tabBar.barTintColor = UIColor(red: 38/255, green: 196/255, blue: 133/255, alpha:1)
        tabBar.barTintColor = .black
        setupTabBar()
    }
    
    func setupTabBar(){
        let homeController = UINavigationController(rootViewController: HomeViewController())
        homeController.tabBarItem.image = UIImage(systemName: "house")
        homeController.tabBarItem.title = "Home"
        
        let plusController = UINavigationController(rootViewController: PlusViewController())
        plusController.tabBarItem.image = UIImage(systemName: "plus")
        plusController.tabBarItem.title = "Plus"
        
        let settinngController = UINavigationController(rootViewController: SettingsViewController())
        settinngController.tabBarItem.image = UIImage(systemName: "gear")
        settinngController.tabBarItem.title = "Setting"

        viewControllers = [homeController, plusController, settinngController]
    }
    

    
}
