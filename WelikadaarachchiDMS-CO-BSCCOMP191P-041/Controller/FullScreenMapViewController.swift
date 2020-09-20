//
//  FullScreenMapViewController.swift
//  WelikadaarachchiDMS-CO-BSCCOMP191P-041
//
//  Created by Mahima Sithuruwan on 9/19/20.
//  Copyright © 2020 Mahima Sithuruwan. All rights reserved.
//

import UIKit
import MapKit
import FirebaseAuth

private let reuseIdentifier = "LocationCell"
private let annotationIdentifier = "UserAnnotation"

class FullScreenMapViewController: UIViewController {
    
    // MARK: - Properties
    
    private let mapView = MKMapView()
    private let locationManager = LocationHandler.shared.locationManager
    var safeArea: UILayoutGuide!
    
    private var user: User? {
        didSet {
            //
        }
    }
    
    private let topNav: UIView = {
        let uv = UIView()
        uv.backgroundColor = .black
        
        let backBtn = UIButton()
        let boldConfig = UIImage.SymbolConfiguration(pointSize: .zero, weight: .bold, scale: .large)
        backBtn.setImage(UIImage(systemName: "chevron.left", withConfiguration: boldConfig), for: .normal)
        backBtn.tintColor = .white
        backBtn.addTarget(self, action: #selector(handleGoBack), for: .touchUpInside)
        uv.addSubview(backBtn)
        backBtn.anchor(left: uv.leftAnchor, paddingLeft: 16, width: 38, height: 38)
        backBtn.centerY(inView: uv)
        
        let titleLbl = UILabel()
        titleLbl.text = "Danger Areas"
        titleLbl.font = UIFont(name: "Avenir-Light", size: 26)
        titleLbl.textColor = .white
        titleLbl.adjustsFontSizeToFitWidth = true
        uv.addSubview(titleLbl)
        titleLbl.centerY(inView: uv)
        titleLbl.centerX(inView: uv)
        
        return uv
    }()
    
    private let mapTile: UIView = {
        let tile = UIView()
        tile.backgroundColor = .black
        return tile
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        safeArea = view.layoutMarginsGuide
        configUI()
        fetchOtherUsers()
    }
    
    // MARK: - Selectors
    
    @objc func handleGoBack() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - API
    
    func fetchOtherUsers() {
        guard let location = locationManager?.location else { return }
        Service.shared.fetchUsersLocation(location: location) { (user) in
            guard let coordinate = user.location?.coordinate else { return }
            let annotation = UserAnnotation(uid: user.uid, coordinate: coordinate)
            
            var usersVisible: Bool {
                
                return self.mapView.annotations.contains { (annotation) -> Bool in
                    guard let userAnno = annotation as? UserAnnotation else { return false }
                    
                    if userAnno.uid == user.uid {
                        userAnno.updateAnnotationPosition(withCoordinate: coordinate)
                        return true
                    }
                    
                    return false
                }
            }
            
            if !usersVisible {
                self.mapView.addAnnotation(annotation)
            }
        }
    }
    
    
    // MARK: - Helper Functions
    
    func configUI() {
        view.backgroundColor = .black
        configNavBar()
        view.addSubview(topNav)
        topNav.anchor(top: safeArea.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: view.bounds.height * 0.1)
        view.addSubview(mapTile)
        mapTile.anchor(top: topNav.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        configMapView()
    }
    
    func configMapView() {
        mapTile.addSubview(mapView)
        mapView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height * 0.9)
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        mapView.delegate = self
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: NSStringFromClass(UserAnnotation.self))
    }
    
    func configNavBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .default
    }
    
}

// MARK: - MKMapViewDelegate

extension FullScreenMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? UserAnnotation {
            let identifier = NSStringFromClass(UserAnnotation.self)
            let view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier, for: annotation)
            if let markerAnnotationView = view as? MKMarkerAnnotationView {
                markerAnnotationView.animatesWhenAdded = true
                markerAnnotationView.canShowCallout = false
                markerAnnotationView.markerTintColor = .red
            }
            return view
        }
        return nil
    }
}

// MARK: - LocationServices

extension FullScreenMapViewController {
    
    func enableLocationServices() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager?.requestWhenInUseAuthorization()
        case .restricted, .denied:
            break
        case .authorizedWhenInUse:
            locationManager?.requestAlwaysAuthorization()
        case .authorizedAlways:
            locationManager?.startUpdatingLocation()
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        default:
            break
        }
    }
}
