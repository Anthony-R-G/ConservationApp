//
//  MGLMapViewController.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/6/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit
import Mapbox

final class MGLMapViewController: UIViewController {
    
    private lazy var mapView: MGLMapView = {
        let mv = MGLMapView()
        let styleURL = URL(string: "mapbox://styles/anthonyg5195/ckdkz8h2n0uri1ir58rf4o707")
        mv.styleURL = MGLStyle.satelliteStreetsStyleURL
        mv.tintColor = .darkGray
        mv.delegate = self
        mv.showsUserLocation = true
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
            for species in speciesData {
                let coordinate = CLLocationCoordinate2D(
                    latitude: species.habitat.latitude,
                    longitude: species.habitat.longitude)
                
                addAnnotation(
                    from: coordinate,
                    title: species.commonName,
                    subtitle: species.habitat.summary)
            }
        }
    }
    
    private var userLocation = CLLocationCoordinate2D()
    
    //MARK: -- Methods
    
    @objc private func changeStyle(sender: UISegmentedControl) {
        Utilities.sendHapticFeedback(action: .selectionChanged)
        switch sender.selectedSegmentIndex {
        case 0:
            mapView.styleURL = MGLStyle.satelliteStreetsStyleURL
        case 1:
            mapView.styleURL = URL(string: "mapbox://styles/anthonyg5195/ckdkz8h2n0uri1ir58rf4o707")
        default:
            ()
        }
    }
    
    private func addAnnotation(from coordinate: CLLocationCoordinate2D,
                               title: String,
                               subtitle: String) {
        let annotation = MGLPointAnnotation()
        
        annotation.coordinate = CLLocationCoordinate2D(
            latitude: coordinate.latitude,
            longitude: coordinate.longitude)
        
        annotation.title = title
        annotation.subtitle = subtitle
        mapView.selectAnnotation(annotation,
                                 animated: true,
                                 completionHandler: nil)
        mapView.addAnnotation(annotation)
    }
    
    @objc private func backButtonPressed() {
        Utilities.sendHapticFeedback(action: .pageDismissed)
        dismiss(animated: true, completion: nil)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setConstraints()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) { [weak self] in
            guard let self = self else { return }
            self.userLocation = self.mapView.userLocation!.coordinate
        }
    }
}

//MARK: -- MapView Delegate Methods
extension MGLMapViewController: MGLMapViewDelegate {
    
    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        
        guard annotation is MGLPointAnnotation else { return nil }
        
        let reuseIdentifier = "\(annotation.coordinate.longitude)"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        
        if annotationView == nil {
            annotationView = CustomAnnotationView(reuseIdentifier: reuseIdentifier)
            annotationView!.bounds = CGRect(origin: .zero, size: CGSize(width: 25, height: 25))
            
            let hue = CGFloat(annotation.coordinate.longitude + annotation.coordinate.latitude) / 100
            annotationView!.backgroundColor = UIColor(
                hue: hue,
                saturation: 0.5,
                brightness: 1,
                alpha: 1)
        }
        
        return annotationView
    }
    
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
    
    
    func mapView(_ mapView: MGLMapView, calloutViewFor annotation: MGLAnnotation) -> MGLCalloutView? {
        //        let locationOne = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
        //        let locationTwo = CLLocation(latitude: speciesLocation.latitude, longitude: speciesLocation.longitude)
        //
        //        let distance = locationOne.distance(from: locationTwo) * 0.000621371
        //
        let title = annotation.title ?? nil
        //        let subtitle = "Distance from you: \(distance.rounded(toPlaces: 1)) miles"
        let subtitle = (annotation.subtitle ?? nil) ?? ""
        let pointAnnotation = MGLPointAnnotation()
        pointAnnotation.title = title
        pointAnnotation.subtitle = subtitle
        pointAnnotation.coordinate = annotation.coordinate
        let callout = CustomCalloutView(annotation: pointAnnotation)
        //        callout.delegate = self
        return callout
    }
}

//MARK: -- CalloutView Delegate Methods
//extension MGLMapViewController: MGLCalloutViewDelegate {
//    func calloutViewWillAppear(_ calloutView: UIView & MGLCalloutView) {
//        print("I will appear")
//    }
//
//    func calloutViewDidAppear(_ calloutView: UIView & MGLCalloutView) {
//        print("I appeared")
//    }
//
//    func calloutViewTapped(_ calloutView: UIView & MGLCalloutView) {
//        print("I was tapped")
//    }
//}


//MARK: -- Add Subviews & Constraints
fileprivate extension MGLMapViewController {
    func addSubviews() {
        [mapView, listButton].forEach { view.addSubview($0) }
    }
    
    func setConstraints() {
        setMapViewConstraints()
        setListButtonConstraints()
        setStyleToggleConstraints()
    }
    
    func setListButtonConstraints() {
        listButton.snp.makeConstraints { (make) in
            make.leading.equalTo(view).inset(Constants.spacing)
            make.top.equalToSuperview().inset(40.deviceScaled)
        }
    }
    
    func setMapViewConstraints() {
        mapView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
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


