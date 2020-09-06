//
//  MGLMapViewController.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/6/20.
//  Copyright © 2020 Antnee. All rights reserved.
//
import Mapbox
import UIKit

final class MGLMapViewController: UIViewController {
    
    private lazy var mapView: MGLMapView = {
        let mv = MGLMapView()
        mv.delegate = self
        mv.showsUserLocation = true
        mv.styleURL = MGLStyle.satelliteStreetsStyleURL
        mv.maximumZoomLevel = 12
        mv.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mv.tintColor = .darkGray
        return mv
    }()
    
    private lazy var listButton: CircleBlurButton = {
        let btn = Factory.makeBlurredCircleButton(image: .list, style: .dark, size: .regular)
        btn.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        return btn
    }()
    
    private lazy var styleToggle: UISegmentedControl = {

        let sc = UISegmentedControl(items: ["Normal", "Hypsometric"])
        sc.tintColor = #colorLiteral(red: 0.976, green: 0.843, blue: 0.831, alpha: 1.0)
        sc.backgroundColor = Constants.Color.red
        sc.layer.cornerRadius = Constants.cornerRadius/2
        sc.clipsToBounds = true
        sc.selectedSegmentIndex = 0
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.addTarget(self, action: #selector(changeStyle(sender:)), for: .valueChanged)
        view.insertSubview(sc, aboveSubview: mapView)
        return sc
    }()
    
    //MARK: -- Properties
    
    var speciesData: [Species] = [] {
        didSet {
            var speciesAnnotations = [SpeciesAnnotation]()
            for species in speciesData {
                let annotation = SpeciesAnnotation(species: species)
                speciesAnnotations.append(annotation)
            }
            mapView.addAnnotations(speciesAnnotations)
        }
    }
    
    private var selectedSpecies: Species!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //MARK: -- Methods
    
    @objc private func changeStyle(sender: UISegmentedControl) {
        Utilities.sendHapticFeedback(action: .selectionChanged)
        switch sender.selectedSegmentIndex {
        case 0:
            mapView.styleURL = URL(string: "mapbox://styles/anthonyg5195/ckej68ntm1e9l19p6jlnf4dh5")
            mapView.maximumZoomLevel = 12
            
        case 1:
            mapView.styleURL = URL(string: "mapbox://styles/anthonyg5195/ckdkz8h2n0uri1ir58rf4o707")
            mapView.maximumZoomLevel = 14
            
        default:
            ()
        }
    }
    
    @objc private func backButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    private func checkLocationPermission() -> Bool {
        var locationPermissionGranted: Bool!
        
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                locationPermissionGranted = false
                
            case .authorizedAlways, .authorizedWhenInUse:
                locationPermissionGranted = true
                
            @unknown default:
                break
            }
        }
        return locationPermissionGranted
    }
    
    private func getDistanceFromUserToSpecies(speciesCoordinate: CLLocationCoordinate2D) -> Double {
        let userLocation = CLLocation(latitude: (mapView.userLocation?.coordinate.latitude)!, longitude: (mapView.userLocation?.coordinate.longitude)!)
        
        let speciesLocation = CLLocation(latitude: speciesCoordinate.latitude, longitude: speciesCoordinate.longitude)
        
        let distance = (userLocation.distance(from: speciesLocation) * 0.000621371).rounded(toPlaces: 1)
        return distance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.frame = view.bounds
        addSubviews()
        setConstraints()
    }
}


//MARK: -- MapView Delegate Methods
extension MGLMapViewController: MGLMapViewDelegate {
    
    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        guard annotation is SpeciesAnnotation else {
            return nil
        }
        
        let reuseIdentifier = "\(annotation.coordinate.longitude)"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        
        if annotationView == nil {
            annotationView = CustomAnnotationView(reuseIdentifier: reuseIdentifier)
            annotationView!.bounds = CGRect(x: 0, y: 0, width: 25, height: 25)
            
            let hue = CGFloat(annotation.coordinate.longitude) / 100
            annotationView!.backgroundColor = UIColor(hue: hue, saturation: 0.5, brightness: 1, alpha: 1)
        }
        return annotationView
    }
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
    
    func mapView(_ mapView: MGLMapView, calloutViewFor annotation: MGLAnnotation) -> MGLCalloutView? {
        guard let annotation = annotation as? SpeciesAnnotation else { return nil }
        var distance: Double? = nil
        
        if checkLocationPermission() {
          distance = getDistanceFromUserToSpecies(speciesCoordinate: annotation.coordinate)
        }
        
        let callout = CustomCalloutView(representedObject: annotation, distance: distance)
        return callout
    }
    
    func mapView(_ mapView: MGLMapView, didSelect annotation: MGLAnnotation) {
        guard let annotation = annotation as? SpeciesAnnotation else { return }
        mapView.setCenter(annotation.coordinate, animated: true)
    }
    
    func mapView(_ mapView: MGLMapView, tapOnCalloutFor annotation: MGLAnnotation) {
        guard let annotation = annotation as? SpeciesAnnotation else { return }
        let coverVC = SpeciesCoverViewController(viewModel: DetailPageStrategyViewModel(species: annotation.species))
       
        let navVC = NavigationController(rootViewController: coverVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true, completion: nil)
    }
}

//MARK: -- Add Subviews & Constraints
fileprivate extension MGLMapViewController {
    func addSubviews() {
        [mapView, listButton].forEach { view.addSubview($0) }
    }
    
    func setConstraints() {
        setListButtonConstraints()
        setStyleToggleConstraints()
    }
    
    func setListButtonConstraints() {
        listButton.snp.makeConstraints { (make) in
            make.leading.equalTo(view).inset(Constants.spacing)
            make.top.equalToSuperview().inset(60.deviceScaled)
        }
    }
    
    func setStyleToggleConstraints() {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(
                item: styleToggle,
                attribute: NSLayoutConstraint.Attribute.centerX,
                relatedBy: NSLayoutConstraint.Relation.equal,
                toItem: mapView,
                attribute: NSLayoutConstraint.Attribute.centerX,
                multiplier: 1.0,
                constant: 0.0)])
        NSLayoutConstraint.activate([
            NSLayoutConstraint(
                item: styleToggle,
                attribute: .bottom,
                relatedBy: .equal,
                toItem: mapView.logoView,
                attribute: .top,
                multiplier: 1,
                constant: -20)])
    }
}


