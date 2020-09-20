//
//  HomeViewController.swift
//  WelikadaarachchiDMS-CO-BSCCOMP191P-041
//
//  Created by Mahima Sithuruwan on 9/10/20.
//  Copyright © 2020 Mahima Sithuruwan. All rights reserved.


import UIKit
import MapKit
import FirebaseAuth
import LocalAuthentication
import GeoFire
import AVFoundation

private let reuseIdentifier = "LocationCell"
private let annotationIdentifier = "UserAnnotation"

class HomeViewController: UIViewController {
    
    //MARK: - Properties
    
    private let mapView = MKMapView()
    private let locationManager = LocationHandler.shared.locationManager
    private var route: MKRoute?
    var safeArea: UILayoutGuide!
    
    private var user: User? {
        didSet {
        }
    }
    
    
    private let mainTile: UIView = {
        let tile = UIView()
        tile.backgroundColor = .black
        
        let avatar = UIImageView()
        avatar.image = UIImage(named: "corona_virus_logo")
        tile.addSubview(avatar)
        avatar.anchor(left: tile.leftAnchor, paddingLeft: 30, width: 125, height: 125)
        avatar.centerY(inView: tile)
        
        let title = UILabel()
        title.text = "All you need is"
        title.font = UIFont(name: "Avenir-Medium", size: 26)
        title.textColor = .white
        tile.addSubview(title)
        title.anchor(top: avatar.topAnchor, left: avatar.rightAnchor, right: tile.rightAnchor, paddingLeft: 30, paddingRight: 16)
        
        let subTitle = UILabel()
        subTitle.text = "stay at home"
        subTitle.font = UIFont(name: "Avenir-Black", size: 30)
        subTitle.textColor = .white
        tile.addSubview(subTitle)
        subTitle.anchor(top: title.bottomAnchor, left: avatar.rightAnchor, right: tile.rightAnchor, paddingLeft: 30, paddingRight: 16)
        
        let safeActions = UIButton()
        let imgConfig = UIImage.SymbolConfiguration(pointSize: 0, weight: .medium, scale: .small)
        safeActions.setTitle("Safe Actions ", for: .normal)
        safeActions.setTitleColor(.green, for: .normal)
        safeActions.setImage(UIImage(systemName: "chevron.left", withConfiguration: imgConfig), for: .normal)
        safeActions.tintColor = .darkGray
        safeActions.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        safeActions.semanticContentAttribute = .forceRightToLeft
        safeActions.sizeToFit()
        safeActions.contentHorizontalAlignment = .left
        safeActions.addTarget(self, action: #selector(showSafeActions), for: .touchUpInside)
        tile.addSubview(safeActions)
        safeActions.anchor(top: subTitle.bottomAnchor, left: avatar.rightAnchor, right: tile.rightAnchor, paddingTop: 15, paddingLeft: 30, paddingRight: 16)
        
        return tile
    }()
    
    private let notificTile: UIButton = {
        let tile = UIButton()
        tile.backgroundColor = .black
        tile.layer.cornerRadius = 5
        tile.layer.masksToBounds = true
        
        let bell = UIImageView()
        bell.image = UIImage(systemName: "bell")
        bell.tintColor = .systemYellow
        tile.addSubview(bell)
        bell.anchor(left: tile.leftAnchor, paddingLeft: 20, width: 32, height: 32)
        bell.centerY(inView: tile)
        
        let arrow = UIImageView()
        arrow.image = UIImage(systemName: "chevron.right")
        arrow.tintColor = .darkGray
        arrow.layer.masksToBounds = true
        tile.addSubview(arrow)
        arrow.anchor(right: tile.rightAnchor, paddingRight: 20, width: 14, height: 26)
        arrow.centerY(inView: tile)
        
        let title = UILabel()
        title.text = "NIBM is closed until further notice"
        title.textColor = .white
        tile.addSubview(title)
        title.anchor(top: tile.topAnchor,  left: bell.rightAnchor, right: arrow.leftAnchor, paddingTop: 15, paddingLeft: 12, paddingRight: 12)
        
        let description = UILabel()
        description.text = "Get quick update about lecture schedule stay tune with LMS"
        description.font = UIFont(name: "Avenir-Medium", size: 12)
        description.textColor = .darkGray
        description.numberOfLines = 2
        tile.addSubview(description)
        description.anchor(top: title.bottomAnchor,  left: bell.rightAnchor, right: arrow.leftAnchor, paddingLeft: 12, paddingRight: 12)
        
        tile.addTarget(self, action: #selector(showNotific), for: .touchUpInside)
        return tile
    }()
    
    private let caseTile: UIView = {
        let tile = UIView()
        tile.backgroundColor = .black
        
        let title = UILabel()
        title.text = "University Case Update"
        title.textColor = .white
        tile.addSubview(title)
        title.anchor(top: tile.topAnchor, left: tile.leftAnchor, paddingTop: 20, paddingLeft: 16)
        
        let moreBtn = UIButton()
        moreBtn.setTitle("See More", for: .normal)
        moreBtn.setTitleColor(.systemBlue, for: .normal)
        moreBtn.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 14)
        tile.addSubview(moreBtn)
        moreBtn.anchor(top: tile.topAnchor, right: tile.rightAnchor, paddingTop: 14, paddingRight: 16)
        
        let timeAgo = UILabel()
        timeAgo.text = "1 minute ago"
        timeAgo.font = UIFont(name: "Avenir-Medium", size: 11)
        timeAgo.textColor = .darkGray
        tile.addSubview(timeAgo)
        timeAgo.anchor(top: title.bottomAnchor, left: tile.leftAnchor, paddingLeft: 16)
        
        let infectedUI = UIView()
        
        let deathsUI = UIView()
        
        let recoveredUI = UIView()
        
        let yellowDot = UIImageView()
        yellowDot.image = UIImage(systemName: "smallcircle.fill.circle")
        yellowDot.tintColor = .systemYellow
        infectedUI.addSubview(yellowDot)
        yellowDot.anchor(top: infectedUI.topAnchor, paddingTop: 18)
        yellowDot.centerX(inView: infectedUI)
        
        let redDot = UIImageView()
        redDot.image = UIImage(systemName: "smallcircle.fill.circle")
        redDot.tintColor = .systemRed
        deathsUI.addSubview(redDot)
        redDot.anchor(top: deathsUI.topAnchor, paddingTop: 18)
        redDot.centerX(inView: deathsUI)
        
        let greenDot = UIImageView()
        greenDot.image = UIImage(systemName: "smallcircle.fill.circle")
        greenDot.tintColor = .systemGreen
        recoveredUI.addSubview(greenDot)
        greenDot.anchor(top: recoveredUI.topAnchor, paddingTop: 18)
        greenDot.centerX(inView: recoveredUI)
        
        let infectedCount = UILabel()
        infectedCount.text = "3"
        infectedCount.font = UIFont(name: "Avenir-Medium", size: 48)
        infectedCount.textColor = .white
        infectedUI.addSubview(infectedCount)
        infectedCount.anchor(top: yellowDot.bottomAnchor, paddingTop: 12)
        infectedCount.centerX(inView: infectedUI)
        
        let deathsCount = UILabel()
        deathsCount.text = "0"
        deathsCount.font = UIFont(name: "Avenir-Medium", size: 48)
        deathsCount.textColor = .white
        deathsUI.addSubview(deathsCount)
        deathsCount.anchor(top: redDot.bottomAnchor, paddingTop: 12)
        deathsCount.centerX(inView: deathsUI)
        
        let recoveredCount = UILabel()
        recoveredCount.text = "12"
        recoveredCount.font = UIFont(name: "Avenir-Medium", size: 48)
        recoveredCount.textColor = .white
        recoveredUI.addSubview(recoveredCount)
        recoveredCount.anchor(top: greenDot.bottomAnchor, paddingTop: 12)
        recoveredCount.centerX(inView: recoveredUI)
        
        let infectedLbl = UILabel()
        infectedLbl.text = "Infected"
        infectedLbl.font = UIFont(name: "Avenir-Medium", size: 14)
        infectedLbl.textColor = .darkGray
        infectedUI.addSubview(infectedLbl)
        infectedLbl.anchor(top: infectedCount.bottomAnchor)
        infectedLbl.centerX(inView: infectedUI)
        
        let deathsLbl = UILabel()
        deathsLbl.text = "Deaths"
        deathsLbl.font = UIFont(name: "Avenir-Medium", size: 14)
        deathsLbl.textColor = .darkGray
        deathsUI.addSubview(deathsLbl)
        deathsLbl.anchor(top: deathsCount.bottomAnchor)
        deathsLbl.centerX(inView: deathsUI)
        
        let recoveredLbl = UILabel()
        recoveredLbl.text = "Recovered"
        recoveredLbl.font = UIFont(name: "Avenir-Medium", size: 14)
        recoveredLbl.textColor = .darkGray
        recoveredUI.addSubview(recoveredLbl)
        recoveredLbl.anchor(top: recoveredCount.bottomAnchor)
        recoveredLbl.centerX(inView: recoveredUI)
        
        let countStack = UIStackView(arrangedSubviews: [infectedUI, deathsUI, recoveredUI])
        countStack.axis = .horizontal
        countStack.distribution = .fillEqually
        countStack.spacing = 0
        tile.addSubview(countStack)
        countStack.anchor(top: timeAgo.bottomAnchor, left: tile.leftAnchor, bottom: tile.bottomAnchor, right: tile.rightAnchor)
        
        return tile
    }()
    
    private let mapTile: UIView = {
        let tile = UIView()
        tile.backgroundColor = .white
        return tile
    }()
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        let screensize: CGRect = UIScreen.main.bounds
        //sv.contentSize = CGSize(width: screensize.width - 2.0, height: 0.84 * screensize.height)
        sv.contentSize = CGSize(width: screensize.width, height: 770)
        sv.translatesAutoresizingMaskIntoConstraints = false
        //sv.backgroundColor = .cyan
        return sv
    }()
    
    // MARK: - Lifecycale
    override func viewDidLoad() {
        super.viewDidLoad()
        safeArea = view.layoutMarginsGuide
        checkIsUserLoggedIn()
        enableLocationServices()
        //signOut()
        view.backgroundColor = .black
    }
    override func viewWillAppear(_ animated: Bool) {
        self.fetchOtherUsers()
        self.updateUserLocation()
    }

    
    // MARK: - API
    
    func checkIsUserLoggedIn() {
        if(Auth.auth().currentUser?.uid == nil) {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: WelcomeViewController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } else {
           // faceID()
            configure()
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginViewController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } catch {
            print("DEBUG: sign out error")
        }
    }
    
    func notifyUser() {
        if !UIApplication.topViewController()!.isKind(of: UIAlertController.self) {
            AudioServicesPlayAlertSound(SystemSoundID(1322))
            let alert = UIAlertController(title: "Warning!", message: "Possible COVID-19 infected person found near you", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    func configure() {
        configureUI()
        fetchUserData()
        fetchOtherUsers()
        
    }
    
    // MARK: - Selectors
    
    @objc func showNotific() {
        let vc = NotificationsVC()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func showFullMap() {
        let vc = FullMapViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func showSafeActions() {
        let vc = SplashOneViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    // MARK: - Helper Function
    
    func configureUI() {
        //let screensize: CGRect = UIScreen.main.bounds
        
        configNavBar()
        view.backgroundColor = .systemGray6
        view.addSubview(scrollView)
        scrollView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        scrollView.addSubview(mainTile)
        mainTile.anchor(top: scrollView.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 200)
        scrollView.addSubview(notificTile)
        notificTile.anchor(top: mainTile.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 8, paddingLeft: 16, paddingRight: 16, height: 80)
        scrollView.addSubview(caseTile)
        caseTile.anchor(top: notificTile.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 8, height: 220)
        scrollView.addSubview(mapTile)
        mapTile.anchor(top: caseTile.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, width: view.bounds.width, height: 270)
        confugireMapView()
    }
    
    func configNavBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .default
    }
    
    
    func confugireMapView() {
        mapTile.addSubview(mapView)
        mapView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 250)
        
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        mapView.delegate = self
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: NSStringFromClass(UserAnnotation.self))
        
    }
    
    // MARK: - API
    func fetchUserData() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        Service.shared.fetchUserData(uid: currentUid) { (user) in
            self.user = user
        }
    }
    
    func fetchOtherUsers() {
        guard let location = locationManager?.location else { return }
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        Service.shared.fetchUsersLocation(location: location) { (user) in
            guard let coordinate = user.location?.coordinate else { return }
            let annotation = UserAnnotation(uid: user.uid, coordinate: coordinate)
            
            let temp = Float(user.temperature)!
            let result = user.surveyResult
            
            var usersVisible: Bool {
                
                return self.mapView.annotations.contains { (annotation) -> Bool in
                    guard let userAnno = annotation as? UserAnnotation else { return false }
                    
                    if userAnno.uid == user.uid {
                        if temp >= 38.0 && result >= 3 {
                            userAnno.updateAnnotationPosition(withCoordinate: coordinate)
                            self.notifyUser()
                            return true
                        }
                    }
                    
                    return false
                }
            }
            
            if !usersVisible {
                // ignore own annotation
                if user.uid != currentUid {
                    if temp >= 38.0 && result >= 3 {
                        self.mapView.addAnnotation(annotation)
                        self.notifyUser()
                    }
                }
            }
        }
        
    }
    
    func updateUserLocation() {
        guard let location = locationManager?.location else { return }
        let receivedLocation : CLLocation! = nil
        
        if !(Auth.auth().currentUser?.uid == nil) && (receivedLocation != nil) {
            let uid = (Auth.auth().currentUser?.uid)!
            let geoFire = GeoFire(firebaseRef: REF_USER_LOCATIONS)
            
            geoFire.setLocation(location, forKey: uid) { (error) in
                if (error != nil) {
                    print("An error occured: \(error!)")
                } else {
                    print("Saved location successfully!")
                }
            }
        }
    }
    
    // MARK:- FaceID
    func faceID(){
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [weak self] success, authenticationError in
                
                DispatchQueue.main.async {
                    if success {
                        let ac = UIAlertController(title: "Authentication Success", message: "Done", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "Be Safe", style: .default))
                        self?.present(ac, animated: true)
                    } else {
                        let ac = UIAlertController(title: "Authentication failed", message: "You could not be verified; please try again.", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        self?.signOut()
                        //  self?.present(ac, animated: true)
                        self?.dismiss(animated: true, completion: nil)
                        
                    }
                }
            }
        }
        else {
            let ac = UIAlertController(title: "Biometry unavailable", message: "Your device is not configured for biometric authentication.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
        }
    }
}

// MARK: - MKMapViewDelegate
extension HomeViewController: MKMapViewDelegate {
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
extension HomeViewController {
    
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

extension MKAnnotationView {
    
    public func set(image: UIImage, with color : UIColor) {
        let view = UIImageView(image: image.withRenderingMode(.alwaysTemplate))
        view.tintColor = color
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        guard let graphicsContext = UIGraphicsGetCurrentContext() else { return }
        view.layer.render(in: graphicsContext)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.image = image
    }
    
}

extension UIApplication {
    
    // To check if UIAlertController presented
    public class func topViewController(_ base: UIViewController? = UIApplication.shared.windows.first?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        return base
    }
    
}
