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
        mv.delegate = self
        return mv
    }()
    
    //MARK: -- Properties
    var habitatLocation = CLLocation() {
        didSet {
            makeMKAnnotation(latitude: habitatLocation.coordinate.latitude, longitude: habitatLocation.coordinate.longitude, title: "Amur Leopard", subtitle: nil)
            mapView.centerToLocation(habitatLocation)
        }
    }
    
    //MARK: -- Methods
    func makeCLLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> CLLocation {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        return location
    }
    
    
    private func makeMKAnnotation(latitude: CLLocationDegrees, longitude: CLLocationDegrees, title: String?, subtitle: String?) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        mapView.addAnnotation(annotation)
        if let title = title {
            annotation.title = title
        }
        if let subtitle = subtitle {
            annotation.subtitle = subtitle
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setConstraints()
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
        guard annotation is MKPointAnnotation else { return nil }
        
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print(view.annotation?.title)
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

