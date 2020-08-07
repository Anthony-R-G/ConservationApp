//
//  MGLMapViewController.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/6/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit
import Mapbox

class MGLMapViewController: UIViewController {
    
    private lazy var mapView: MGLMapView = {
        let mv = MGLMapView()
        mv.styleURL = MGLStyle.satelliteStreetsStyleURL
        mv.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mv.tintColor = .darkGray
        mv.delegate = self
        mv.userTrackingMode = .none
        mv.showsUserLocation = true
        return mv
    }()
    
    private lazy var backButton: UIButton = {
        let btn = Factory.makeButton(title: "Back", weight: .medium, color: .white)
        btn.layer.borderWidth = Constants.borderWidth
        btn.layer.cornerRadius = 10
        btn.layer.borderColor = UIColor.white.cgColor
        btn.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        return btn
    }()
    
    //MARK: -- Properties
    
    var currentSpecies: Species! {
        didSet {
            speciesLocation = CLLocationCoordinate2D(latitude: currentSpecies.habitat.latitude, longitude: currentSpecies.habitat.longitude)
        }
    }
    
    private var speciesLocation = CLLocationCoordinate2D() {
        didSet {
            addAnnotation(from: speciesLocation, title: currentSpecies.commonName, subtitle: currentSpecies.taxonomy.scientificName)
            
        }
    }
    
    
    var userLocation = CLLocationCoordinate2D() {
        didSet {
            print("User Location: \(userLocation)")
            let locationOne = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
            let locationTwo = CLLocation(latitude: speciesLocation.latitude, longitude: speciesLocation.longitude)

            let distance = locationOne.distance(from: locationTwo) * 0.000621371

            print(distance.rounded(toPlaces: 1))
        }
    }
    
    //MARK: -- Methods
    
    func addAnnotation(from coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        let annotation = MGLPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        annotation.title = title
        annotation.subtitle = subtitle
        mapView.addAnnotation(annotation)
    }
    
    @objc private func backButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    var testCoord1 = CLLocationCoordinate2D(latitude: 32.9697, longitude: -96.80322)
    var testCoord2 = CLLocationCoordinate2D(latitude: 29.46786, longitude: -98.53506)
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setConstraints()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.userLocation = self.mapView.userLocation!.coordinate
        }
    }
}

extension MGLMapViewController: MGLMapViewDelegate {
    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
        
        let camera = MGLMapCamera(lookingAtCenter: speciesLocation , altitude: 100000, pitch: 15, heading: 0)
        
        print("Species Location: \(speciesLocation)")
        
        
        mapView.setCamera(camera, withDuration: 3, animationTimingFunction: CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut))
    }
    
    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        return nil
    }
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
    
    func mapView(_ mapView: MGLMapView, calloutViewFor annotation: MGLAnnotation) -> MGLCalloutView? {
        
        let title = annotation.title ?? nil
        let subtitle = annotation.subtitle ?? nil
        let customAnnotation = SpeciesAnnotation(coordinate: annotation.coordinate, title: title ?? "no title", subtitle: subtitle ?? "no subtitle")
        
        return CustomCalloutView(annotation: customAnnotation)
    }
}


//MARK: -- Add Subviews & Constraints
fileprivate extension MGLMapViewController {
    func addSubviews() {
        let UIElements = [mapView, backButton]
        UIElements.forEach { view.addSubview($0) }
        UIElements.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    func setConstraints() {
        setMapViewConstraints()
        setBackButtonConstraints()
    }
    
    func setBackButtonConstraints() {
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            backButton.heightAnchor.constraint(equalToConstant: 40),
            backButton.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    func setMapViewConstraints() {
        NSLayoutConstraint.activate([
            mapView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mapView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mapView.heightAnchor.constraint(equalToConstant: view.bounds.size.height),
            mapView.widthAnchor.constraint(equalToConstant: view.bounds.size.width)
        ])
    }
}


