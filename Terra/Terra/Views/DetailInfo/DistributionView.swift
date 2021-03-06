//
//  SpeciesMapView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/17/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Mapbox

final class DistributionView: UIView {
    //MARK: -- UI Element Initialization
    
    private lazy var mapView: MGLMapView = {
        let mv = MGLMapView()
        let styleURL = URL(string: species.habitat.mapboxStyleURL)
        mv.styleURL = styleURL
        mv.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mv.tintColor = .white
        mv.layer.cornerRadius = Constants.cornerRadius
        mv.clipsToBounds = true
        mv.delegate = self
        return mv
    }()
    
    //MARK: -- Properties
    private var species: Species!
    
    private var speciesLocation = CLLocationCoordinate2D()
    
    //MARK: -- Methods
    
    required init(species: Species) {
        super.init(frame: .zero)
        self.species = species
        speciesLocation = CLLocationCoordinate2D(
            latitude: species.habitat.latitude,
            longitude: species.habitat.longitude)
        
        heightAnchor.constraint(equalToConstant: 460.deviceScaled).isActive = true
        
        addSubview(mapView)
        mapView.snp.makeConstraints { (make) in
            make.height.width.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: -- Map View Delegate
extension DistributionView: MGLMapViewDelegate {
    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
        
        let camera = MGLMapCamera(lookingAtCenter: speciesLocation,
                                  altitude: species.habitat.mapboxZoomAltitude,
                                  pitch: 15,
                                  heading: 0)
        mapView.setCamera(camera,
                          withDuration: 1.0,
                          animationTimingFunction: CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut))
    }
}
