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
        let styleURL = URL(string: "mapbox://styles/anthonyg5195/ckdyqfk5g034c19pit394euia")
        mv.styleURL = styleURL
        mv.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mv.tintColor = .darkGray
//        mv.zoomLevel = 2
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
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension SpeciesMapView: MGLMapViewDelegate {
    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let camera = MGLMapCamera(lookingAtCenter: self.speciesLocation , altitude: 6000000, pitch: 15, heading: 0)
            mapView.setCamera(camera,
                              withDuration: 1.2,
                              animationTimingFunction: CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut))
        }
    }
}



//MARK: -- Add Subviews & Constraints
extension SpeciesMapView {
    func addSubviews() {
        [mapView].forEach{ addSubview($0) }
    }
    
    func setConstraints() {
        setMapConstraints()
    }
    
    func setMapConstraints() {
        mapView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
}

