//
//  SafeActionsViewController.swift
//  WelikadaarachchiDMS-CO-BSCCOMP191P-041
//
//  Created by Mahima Sithuruwan on 9/13/20.
//  Copyright © 2020 Mahima Sithuruwan. All rights reserved.

import UIKit

class SafeActionsViewController: UIViewController {
    
    // MARK: - Properties
    
    private let backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "back_black"), for: .normal)
        button.addTarget(self, action: #selector(handleGoBack), for: .touchUpInside)
        return button
    }()
    
    private let titleLbl: UILabel = {
        let label = UILabel()
        label.text = "Safe Actions"
        label.font = UIFont(name: "Avenir-Light", size: 30)
        label.textColor = UIColor.black
        return label
    }()
    
    //let scrollView = UIScrollView()
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        let screensize: CGRect = UIScreen.main.bounds
        sv.contentSize = CGSize(width: screensize.width - 2.0, height: screensize.height + 2.0)
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.backgroundColor = .white
        return sv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    

    private func configUI() {
        configNavBar()
        
        // setup scrollview
        let screensize: CGRect = view.bounds
        let titles = ["Wash Your Hands", "Location", "All Set"]
        
        view.backgroundColor = .systemGray6
        view.addSubview(backButton)
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 20, paddingLeft: 16, paddingBottom: 20, width: 40, height: 40)
        view.addSubview(titleLbl)
        titleLbl.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20, paddingBottom: 20)
        titleLbl.centerX(inView: view)
        
        //scrollView.frame = screensize
        view.addSubview(scrollView)
        scrollView.anchor(top: titleLbl.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
        for x in 0..<3 {
            let pageView = UIView(frame: CGRect(x: CGFloat(x) * screensize.width, y: 0, width: screensize.width, height: screensize.height-titleLbl.frame.size.height))
            scrollView.addSubview(pageView)
            
            // title, image, button
            let label = UILabel(frame: CGRect(x:  10, y: 10, width: pageView.frame.size.width-20, height: 80))
            let imageView = UIImageView(frame: CGRect(x:  10, y: 10+120+10, width: pageView.frame.size.width-20, height: pageView.frame.size.height-60-130-15))
//            let button = UIButton(type: .system)
            let button = UIButton(frame: CGRect(x:  10, y: pageView.frame.size.height-60, width: pageView.frame.size.width-20, height: 50))
            
            label.textAlignment = .center
            label.font = UIFont(name: "MarkerFelt-Wide", size: 24)
            //label.font = UIFont(name: "Chalkduster", size: 24)
            //label.font = UIFont(name: "ChalkboardSE-Bold", size: 24)
            pageView.addSubview(label)
            label.text = titles[x]
            
            imageView.contentMode = .scaleAspectFit
            imageView.image = UIImage(named: "welcome_\(x)")
            pageView.addSubview(imageView)
            
//            let buttonTitle = NSMutableAttributedString(string: "NEXT", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.gray])
//            button.setAttributedTitle(buttonTitle, for: .normal)
            button.setTitle("NEXT", for: .normal)
            if(x == 2) {
               button.setTitle("DONE!", for: .normal)
            }
            button.setTitleColor(.gray, for: .normal)
            button.addTarget(self, action: #selector(handleTapNext(_:)), for: .touchUpInside)
            button.tag = x+1
            pageView.addSubview(button)
            //nextButton.anchor(bottom: pageView.bottomAnchor, paddingBottom: 30)
            //nextButton.centerX(inView: view)
        }
        
        scrollView.contentSize = CGSize(width: screensize.width * 3 , height: 0)
        scrollView.isPagingEnabled = true
         
    }
    
    func configNavBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .default
    }
    
    // MARK: - Selectors
    
    @objc func handleTapNext(_ button: UIButton) {
        guard button.tag < 3 else {
            // dismiss
            return
        }
        // scroll to next page
        scrollView.setContentOffset(CGPoint(x: view.bounds.width * CGFloat(button.tag), y: 0), animated: true)
    }
    
    @objc func handleGoBack() {
       navigationController?.popViewController(animated: true)
    }

}
