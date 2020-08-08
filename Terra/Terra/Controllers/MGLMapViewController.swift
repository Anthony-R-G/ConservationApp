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
        
        let styleURL = URL(string: "mapbox://styles/anthonyg5195/ckdkz8h2n0uri1ir58rf4o707")
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
        btn.layer.cornerRadius = 10
        btn.tintColor = UIColor(red: 0.976, green: 0.843, blue: 0.831, alpha: 1)
        btn.backgroundColor = Constants.red
        btn.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        return btn
    }()
    
    private lazy var styleToggle: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Normal", "Hypsometric"])
        sc.tintColor = UIColor(red: 0.976, green: 0.843, blue: 0.831, alpha: 1)
        sc.backgroundColor = Constants.red
        sc.layer.cornerRadius = 10
        sc.clipsToBounds = true
        sc.selectedSegmentIndex = 0
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.addTarget(self, action: #selector(changeStyle(sender:)), for: .valueChanged)
        view.insertSubview(sc, aboveSubview: mapView)
        return sc
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
    
    private var userLocation = CLLocationCoordinate2D()
    
    //MARK: -- Methods
    
    @objc private func changeStyle(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            mapView.styleURL = MGLStyle.satelliteStreetsStyleURL
        case 1:
            mapView.styleURL = URL(string: "mapbox://styles/anthonyg5195/ckdkz8h2n0uri1ir58rf4o707")
            
        default:
            mapView.styleURL = MGLStyle.streetsStyleURL
        }
    }
    
    private func addAnnotation(from coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        let annotation = MGLPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        annotation.title = title
        annotation.subtitle = subtitle
        mapView.selectAnnotation(annotation, animated: true, completionHandler: nil)
        mapView.addAnnotation(annotation)
    }
    
    @objc private func backButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setConstraints()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self = self else { return }
            self.userLocation = self.mapView.userLocation!.coordinate
        }
        
    }
}

extension MGLMapViewController: MGLMapViewDelegate {
    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
        let camera = MGLMapCamera(lookingAtCenter: speciesLocation , altitude: 100000, pitch: 15, heading: 0)
        mapView.setCamera(camera,
                          withDuration: 3,
                          animationTimingFunction: CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut))
    }
    
    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        
        guard annotation is MGLPointAnnotation else { return nil }
        
        let reuseIdentifier = "\(annotation.coordinate.longitude)"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        
        if annotationView == nil {
            annotationView = CustomAnnotationView(reuseIdentifier: reuseIdentifier)
            annotationView!.bounds = CGRect(x: 0, y: 0, width: 40, height: 40)
            
            let hue = CGFloat(annotation.coordinate.longitude) / 100
            annotationView!.backgroundColor = UIColor(hue: hue, saturation: 0.5, brightness: 1, alpha: 1)
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
    
    func mapView(_ mapView: MGLMapView, calloutViewFor annotation: MGLAnnotation) -> MGLCalloutView? {
        let locationOne = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
        let locationTwo = CLLocation(latitude: speciesLocation.latitude, longitude: speciesLocation.longitude)
        
        let distance = locationOne.distance(from: locationTwo) * 0.000621371
        
        let title = annotation.title ?? nil
        let subtitle = "Distance from you: \(distance.rounded(toPlaces: 1)) miles"
        let customAnnotation = SpeciesAnnotation(coordinate: annotation.coordinate, title: title ?? "no title", subtitle: subtitle, area: currentSpecies.habitat.area)
        let callout = CustomCalloutView(annotation: customAnnotation)
        callout.delegate = self
        return callout
    }
}

extension MGLMapViewController: MGLCalloutViewDelegate {
    func calloutViewWillAppear(_ calloutView: UIView & MGLCalloutView) {
        print("I will appear")
    }
    
    func calloutViewDidAppear(_ calloutView: UIView & MGLCalloutView) {
        print("I appeared")
    }
    
    func calloutViewTapped(_ calloutView: UIView & MGLCalloutView) {
        print("I was tapped")
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
        setStyleToggleConstraints()
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
    
    func setStyleToggleConstraints() {
        NSLayoutConstraint.activate([NSLayoutConstraint(item: styleToggle, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: mapView, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1.0, constant: 0.0)])
        NSLayoutConstraint.activate([NSLayoutConstraint(item: styleToggle, attribute: .bottom, relatedBy: .equal, toItem: mapView.logoView, attribute: .top, multiplier: 1, constant: -20)])
    }
}


class CustomAnnotationView: MGLAnnotationView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Use CALayer’s corner radius to turn this view into a circle.
        layer.cornerRadius = bounds.width / 2
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Animate the border width in/out, creating an iris effect.
        let animation = CABasicAnimation(keyPath: "borderWidth")
        animation.duration = 0.1
        layer.borderWidth = selected ? bounds.width / 4 : 2
        layer.add(animation, forKey: "borderWidth")
    }
}
