//
//  SurveyCell.swift
//  WelikadaarachchiDMS-CO-BSCCOMP191P-041
//
//  Created by Mahima Sithuruwan on 9/13/20.
//  Copyright © 2020 Mahima Sithuruwan. All rights reserved.


import UIKit

protocol SurveyCellDelegate: class {
    func didChooseAnswer(btnIndex: Int)
}

class SurveyCell: UICollectionViewCell {
    
    var btnYes: UIButton!
    var btnNo: UIButton!
    var btnsArray = [UIButton]()
    var safeArea: UILayoutGuide!
  
    weak var delegate: SurveyCellDelegate?
    
    var question: Question? {
        didSet {
            guard let unwrappedQue = question else { return }
            imgView.image = UIImage(named: unwrappedQue.imgName)
            lblQue.text = unwrappedQue.questionText
            btnYes.setTitle("YES", for: .normal)
            btnNo.setTitle("NOPE", for: .normal)
            
            if unwrappedQue.isAnswered {
                if unwrappedQue.accept == true {
                    btnYes.backgroundColor = .blue
                } else {
                    btnNo.backgroundColor = .blue
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        btnsArray = [btnYes, btnNo]
    }
    
    @objc func btnOptionAction(sender: UIButton) {
        guard let unwrappedQue = question else { return }
        if !unwrappedQue.isAnswered {
            delegate?.didChooseAnswer(btnIndex: sender.tag)
        }
    }
    
    override func prepareForReuse() {
        btnYes.backgroundColor=UIColor.white
        btnNo.backgroundColor=UIColor.white
    }
    
//    @objc func btnGoBackAction() {
//        self.navigationController?.popToRootViewController(animated: true)
//    }
    
    func setupViews() {
        addSubview(imgView)
        imgView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 100).isActive=true
        imgView.widthAnchor.constraint(equalToConstant: 350).isActive=true
        imgView.heightAnchor.constraint(equalToConstant: 300).isActive=true
        imgView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive=true
        
        addSubview(lblQue)
        lblQue.topAnchor.constraint(equalTo: imgView.bottomAnchor).isActive=true
        lblQue.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12).isActive=true
        lblQue.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12).isActive=true
        lblQue.heightAnchor.constraint(equalToConstant: 150).isActive=true
        
        let btnWidth: CGFloat = 150
        let btnHeight: CGFloat = 50
        btnYes = getButton(tag: 0)
        addSubview(btnYes)
        NSLayoutConstraint.activate([btnYes.topAnchor.constraint(equalTo: lblQue.bottomAnchor, constant: -40), btnYes.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: -10), btnYes.widthAnchor.constraint(equalToConstant: btnWidth), btnYes.heightAnchor.constraint(equalToConstant: btnHeight)])
        btnYes.addTarget(self, action: #selector(btnOptionAction), for: .touchUpInside)
        
        btnNo = getButton(tag: 1)
        addSubview(btnNo)
        NSLayoutConstraint.activate([btnNo.topAnchor.constraint(equalTo: btnYes.topAnchor), btnNo.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: 10), btnNo.widthAnchor.constraint(equalToConstant: btnWidth), btnNo.heightAnchor.constraint(equalToConstant: btnHeight)])
        btnNo.addTarget(self, action: #selector(btnOptionAction), for: .touchUpInside)
        
//        addSubview(btnGoBack)
//        btnGoBack.topAnchor.constraint(equalTo: btnYes.bottomAnchor, constant: 40).isActive=true
//        //btnGoBack.centerXAnchor.constraint(equalTo: btnYes.bottomAnchor).isActive=true
//        btnGoBack.widthAnchor.constraint(equalToConstant: 150).isActive=true
//        btnGoBack.heightAnchor.constraint(equalToConstant: 50).isActive=true
//       // btnGoBack.addTarget(self, action: #selector(btnGoBackAction), for: .touchUpInside)
    }
    
    let btnGoBack: UIButton = {
        let btn = UIButton()
        btn.setTitle("Go Back", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    func getButton(tag: Int) -> UIButton {
        let btn=UIButton()
        btn.tag=tag
        btn.setTitle("Option", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .white
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.darkGray.cgColor
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints=false
        return btn
    }
    
    let imgView: UIImageView = {
        let imgV=UIImageView()
        imgV.image = #imageLiteral(resourceName: "ic_person_outline_white_2x")
        imgV.contentMode = .scaleAspectFit
        imgV.translatesAutoresizingMaskIntoConstraints=false
        return imgV
    }()
    
    let lblQue: UILabel = {
        let lbl=UILabel()
        lbl.text="This is a question and you have to answer it?"
        lbl.textColor=UIColor.black
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.numberOfLines=4
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
