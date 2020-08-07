//
//  CustomCalloutView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/7/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit
import Mapbox
import FirebaseUI

class CustomCalloutView: UIView, MGLCalloutView {
    
    //MARK: UI Element Initialization
    
    private lazy var titleLabel: UILabel = {
        return Factory.makeLabel(title: nil,
                                 weight: .medium,
                                 size: 18,
                                 color: .white,
                                 alignment: .left)
    }()
    
    private lazy var subtitleLabel: UILabel = {
        return Factory.makeLabel(title: nil,
                                 weight: .regular,
                                 size: 14,
                                 color: .white,
                                 alignment: .left)
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        insertSubview(iv, at: 0)
        return iv
    }()
    
    private lazy var blackBar: UIView = {
        let bar = UIView()
        bar.backgroundColor = .black
        bar.clipsToBounds = true
        bar.translatesAutoresizingMaskIntoConstraints = false
        
        return bar
    }()
    
    //MARK: -- Properties
    
    var representedObject: MGLAnnotation
    // Required views but unused for now
    lazy var leftAccessoryView = UIView()
    lazy var rightAccessoryView = UIView()
    
    
    weak var delegate: MGLCalloutViewDelegate?
    
    
    //MARK: -- Methods
    
    func presentCallout(from rect: CGRect, in view: UIView, constrainedTo constrainedRect: CGRect, animated: Bool) {
        center = view.center.applying(CGAffineTransform(translationX: 0, y: -self.frame.height))
        view.addSubview(self)
    }
    
    func dismissCallout(animated: Bool) {
        if (animated){
            removeFromSuperview()
        } else {
            removeFromSuperview()
        }
    }
    
    var dismissesAutomatically: Bool = false
    var isAnchoredToAnnotation: Bool = true
    
    required init(annotation: SpeciesAnnotation) {
        self.representedObject = annotation
        
        super.init(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: UIScreen.main.bounds.width * 0.75, height: 180.0)))
        
        self.titleLabel.text = self.representedObject.title ?? ""
        self.subtitleLabel.text = self.representedObject.subtitle ?? ""
     
        clipsToBounds = true
        layer.cornerRadius = 10
        
        
        addSubviews()
        setConstraints()
        FirebaseStorageService.cellImageManager.getImage(for: annotation.title!, setTo: backgroundImageView)

    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: -- Add Subviews & Constraints
fileprivate extension CustomCalloutView {
    
    func addSubviews() {
        let UIElements = [blackBar, titleLabel, subtitleLabel]
        UIElements.forEach { addSubview($0) }
        UIElements.forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    func setConstraints() {
        setBlackBarConstraints()
        setBackgroundImageConstraints()
        setTitleLabelConstraints()
        setSubtitleLabelConstraints()
    }
    
    
    func setTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.universalLeadingConstant),
            titleLabel.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: 5),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 30)
            
        ])
    }
    
    func setSubtitleLabelConstraints() {
        NSLayoutConstraint.activate([
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.universalLeadingConstant),
            subtitleLabel.widthAnchor.constraint(equalTo: widthAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            subtitleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func setBackgroundImageConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: blackBar.topAnchor)
        ])
    }
    
    func setBlackBarConstraints() {
        NSLayoutConstraint.activate([
            blackBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            blackBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            blackBar.bottomAnchor.constraint(equalTo: bottomAnchor),
            blackBar.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4)
        ])
    }
}
