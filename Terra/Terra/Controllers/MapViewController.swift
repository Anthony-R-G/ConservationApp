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
    
    private lazy var mapView: MKMapView = {
        let mv = MKMapView()
        mv.mapType = .satellite
        mv.delegate = self
        return mv
    }()
    
    var speciesHabitat: Habitat! {
        didSet {
            addMapAnnotation(latitude: speciesHabitat.latitude, longitude: speciesHabitat.longitude)
            zoomToArea()
        }
    }
    
    private func zoomToArea() {
        let locationCoordinate = CLLocationCoordinate2D(latitude: speciesHabitat.latitude, longitude: speciesHabitat.longitude)
        mapView.centerCoordinate = locationCoordinate
        let region = MKCoordinateRegion(center: locationCoordinate, latitudinalMeters: 9484.1, longitudinalMeters: 9484.1)
        mapView.setRegion(region, animated: true)
    }
    
    private func addMapAnnotation(latitude: Double, longitude: Double) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        mapView.addAnnotation(annotation)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setConstraints()
       
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
}

