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
        let styleURL = URL(string: viewModel.speciesMapboxStyleURL)
        mv.styleURL = styleURL
        mv.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mv.tintColor = .white
        mv.layer.cornerRadius = Constants.cornerRadius
        mv.clipsToBounds = true
        mv.delegate = self
        return mv
    }()
    
    //MARK: -- Properties
    private var viewModel: SpeciesDetailViewModel
    
    private var speciesLocation = CLLocationCoordinate2D()
    
    //MARK: -- Methods
    
    required init(viewModel: SpeciesDetailViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        speciesLocation = CLLocationCoordinate2D(
            latitude: viewModel.speciesLatitudeCoordinate,
            longitude: viewModel.speciesLongitudeCoordinate)
        
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
                                  altitude: viewModel.speciesMapboxZoomAltitude,
                                  pitch: 15,
                                  heading: 0)
        mapView.setCamera(camera,
                          withDuration: 1.0,
                          animationTimingFunction: CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut))
    }
}
