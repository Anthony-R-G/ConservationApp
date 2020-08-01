//
//  MapViewController.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/30/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    //MARK: -- UI Element Initialization
    private lazy var mapView: MKMapView = {
        let mv = MKMapView()
        mv.mapType = .satelliteFlyover
        mv.showsTraffic = false
        return mv
    }()
    
    //MARK: -- Properties
    
    var currentSpecies: Species! {
        didSet {
            habitatLocation = makeCLLocation(latitude: currentSpecies.habitat.latitude, longitude: currentSpecies.habitat.longitude)
        }
    }
    
    
    private var habitatLocation = CLLocation() {
        didSet {
            makeAnnotation(latitude: habitatLocation.coordinate.latitude, longitude: habitatLocation.coordinate.longitude, title: currentSpecies.commonName , subtitle: nil)
            mapView.centerToLocation(habitatLocation)
            
        }
    }
    
    //MARK: -- Methods
    private func makeCLLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> CLLocation {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        return location
    }
    
    
    private func makeAnnotation(latitude: CLLocationDegrees, longitude: CLLocationDegrees, title: String, subtitle: String?) {
        let annotation = SpeciesAnnotation(title: currentSpecies.commonName, subtitle: currentSpecies.taxonomy.scientificName, coordinate: CLLocationCoordinate2D(latitude: habitatLocation.coordinate.latitude, longitude: habitatLocation.coordinate.longitude))
        mapView.addAnnotation(annotation)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setConstraints()
        mapView.delegate = self
        let annotation = SpeciesAnnotation(title: currentSpecies.commonName, subtitle: currentSpecies.taxonomy.scientificName, coordinate: CLLocationCoordinate2D(latitude: currentSpecies.habitat.latitude, longitude: currentSpecies.habitat.longitude))
        mapView.addAnnotation(annotation)
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


//MARK: --Add Subviews & Set Constraints

extension MapViewController {
    private func addSubviews() {
        let UIElements = [mapView]
        UIElements.forEach { view.addSubview($0) }
        UIElements.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func setConstraints() {
        setMapViewConstraints()
    }
    
    private func setMapViewConstraints() {
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

