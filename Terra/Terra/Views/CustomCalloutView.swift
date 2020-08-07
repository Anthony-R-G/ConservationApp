//
//  CustomCalloutView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/7/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit
import Mapbox

class CustomCallOutView: UIView, MGLCalloutView {
    
    var representedObject: MGLAnnotation
    
    // Required views but unused for now
    lazy var leftAccessoryView = UIView()
    lazy var rightAccessoryView = UIView()
    
    var delegate: MGLCalloutViewDelegate?
    
    required init(annotation: SpeciesAnnotation) {
        self.representedObject = annotation
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func presentCallout(from rect: CGRect, in view: UIView, constrainedTo constrainedRect: CGRect, animated: Bool) {
        view.addSubview(self)
    }
    
    func dismissCallout(animated: Bool) {
        if (animated){
            //do something cool
            removeFromSuperview()
        } else {
            removeFromSuperview()
        }
    }
}
