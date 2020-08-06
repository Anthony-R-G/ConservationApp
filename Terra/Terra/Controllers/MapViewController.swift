//
//  MapViewController.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/30/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    //MARK: -- UI Element Initialization
    
    private lazy var backButton: UIButton = {
        let btn = Factory.makeButton(title: "Back", weight: .medium, color: .white)
        btn.layer.borderWidth = Constants.borderWidth
        btn.layer.cornerRadius = 10
        btn.layer.borderColor = UIColor.white.cgColor
        btn.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        return btn
    }()
    private lazy var mapView: MKMapView = {
        let mv = MKMapView()
        mv.mapType = .hybridFlyover
        mv.showsTraffic = false
        mv.showsUserLocation = true
        mv.delegate = self
        return mv
    }()
    
    //MARK: -- Properties
    
    var currentSpecies: Species! {
        didSet {
            speciesLocation = makeCLLocation(latitude: currentSpecies.habitat.latitude, longitude: currentSpecies.habitat.longitude)
        }
    }
    
    private var speciesLocation = CLLocation() {
        didSet {
            makeAnnotation(latitude: speciesLocation.coordinate.latitude, longitude: speciesLocation.coordinate.longitude, title: currentSpecies.commonName , subtitle: nil)
            mapView.centerToLocation(speciesLocation)
            
        }
    }
    
    private var locationManager = CLLocationManager()
    
    //MARK: -- Methods
    
    @objc private func backButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    private func makeCLLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> CLLocation {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        return location
    }
    
    
    private func makeAnnotation(latitude: CLLocationDegrees, longitude: CLLocationDegrees, title: String, subtitle: String?) {
        let annotation = SpeciesAnnotation(title: currentSpecies.commonName, subtitle: currentSpecies.taxonomy.scientificName, coordinate: CLLocationCoordinate2D(latitude: speciesLocation.coordinate.latitude, longitude: speciesLocation.coordinate.longitude))
        mapView.addAnnotation(annotation)
    }
    
    
    private func calculateDistanceFromUserToSpecies(speciesCoordinate: CLLocation) {
        let distanceInMeters = speciesCoordinate.distance(from: locationManager.location!)
        let distanceInMiles = distanceInMeters.metersToMiles
        print(distanceInMiles.rounded(toPlaces: 1))
    }
    
    private func requestLocationAccess() {
           let status = CLLocationManager.authorizationStatus()
           
           switch status {
           case .authorizedAlways, .authorizedWhenInUse:
               return
               
           case .denied, .restricted:
               print("location access denied")
               
           default:
               locationManager.requestWhenInUseAuthorization()
           }
       }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setConstraints()
        locationManager.delegate = self
        requestLocationAccess()
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        calculateDistanceFromUserToSpecies(speciesCoordinate: speciesLocation)
    }
}

private extension MKMapView {
    func centerToLocation(
        _ location: CLLocation,
        regionRadius: CLLocationDistance = 200000
    ) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}

//MARK: -- MapView Delegate Methods

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? SpeciesAnnotation else {
            return nil
        }
        
        let identifier = "species"
        var view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        
        return view
    }
}

//MARK: --CLLocationManagerDelegate Methods

extension MapViewController: CLLocationManagerDelegate {
    
}


//MARK: -- Add Subviews & Set Constraints

fileprivate extension MapViewController {
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
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}


