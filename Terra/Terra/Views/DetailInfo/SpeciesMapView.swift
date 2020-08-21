//
//  SpeciesMapView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/17/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Mapbox

final class SpeciesMapView: UIView {
    
    private lazy var mapView: MGLMapView = {
        let mv = MGLMapView()
        let styleURL = URL(string: species.habitat.mapboxStyleURL)
        mv.styleURL = styleURL
        mv.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mv.tintColor = .white
        mv.layer.cornerRadius = Constants.cornerRadius
        mv.clipsToBounds = true
        //        mv.zoomLevel = 2.25
        //        mv.zoomLevel = 8
        //        mv.minimumZoomLevel = 2
        //        mv.maximumZoomLevel = 1.8
        mv.delegate = self
        return mv
    }()
    
    private var species: Species!
    
    private var speciesLocation = CLLocationCoordinate2D()
    
    required init(species: Species) {
        self.species = species
        speciesLocation = CLLocationCoordinate2D(latitude: species.habitat.latitude, longitude: species.habitat.longitude)
        super.init(frame: .zero)
        addSubviews()
        setConstraints()
        heightAnchor.constraint(equalToConstant: 460).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SpeciesMapView: MGLMapViewDelegate {
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

//MARK: -- Add Subviews & Constraints

fileprivate extension SpeciesMapView {
    func addSubviews() {
        [mapView].forEach{ addSubview($0) }
    }
    
    func setConstraints() {
        setMapConstraints()
    }
    
    func setMapConstraints() {
        mapView.snp.makeConstraints { [weak self] (make) in
            guard let self = self else { return }
            make.edges.equalTo(self)
        }
    }
}

