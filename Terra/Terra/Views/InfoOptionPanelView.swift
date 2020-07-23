//
//  InfoOptionPanelView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/20/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

class InfoOptionPanelView: UIView {
    
    //MARK: -- UI Element Initialization
    lazy var overviewButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Overview", for: .normal)
        btn.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 13)
        btn.setTitleColor(.white, for: .normal)
        btn.setTitleColor(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), for: .selected)
        btn.addTarget(self, action: #selector(overviewButtonPressed), for: .touchUpInside)
        return btn
    }()
    
    lazy var threatsButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Threats", for: .normal)
        btn.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 13)
        btn.setTitleColor(.white, for: .normal)
        btn.setTitleColor(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), for: .selected)
        btn.addTarget(self, action: #selector(threatsButtonPressed), for: .touchUpInside)
        return btn
    }()
    
    lazy var habitatButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Habitat", for: .normal)
        btn.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 13)
        btn.setTitleColor(.white, for: .normal)
        btn.setTitleColor(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), for: .selected)
        btn.addTarget(self, action: #selector(threatsButtonPressed), for: .touchUpInside)
        return btn
    }()
    
    lazy var galleryButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Gallery", for: .normal)
        btn.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 13)
        btn.setTitleColor(.white, for: .normal)
        btn.setTitleColor(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), for: .selected)
        btn.addTarget(self, action: #selector(threatsButtonPressed), for: .touchUpInside)
        return btn
    }()
    
    //MARK: -- Properties
    
    var delegate: InfoOptionPanelDelegate?
    
    private var shapeLayer: CALayer?
    
    //MARK: -- Methods
    
    @objc func overviewButtonPressed() {
        delegate?.overviewButtonPressed(overviewButton)
    }
    
    @objc func threatsButtonPressed() {
        delegate?.threatsButtonPressed(threatsButton)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 25
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: -- Adding Subviews & Constraints

extension InfoOptionPanelView {
    
    private func addSubviews() {
        let UIElements = [overviewButton, threatsButton, habitatButton, galleryButton]
        UIElements.forEach { self.addSubview($0) }
        UIElements.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func setConstraints() {
        setOverviewButtonConstraints()
        setThreatsButtonConstraints()
        setHabitatButtonConstraints()
        setGalleryButtonConstraints()
    }
    
    private func setOverviewButtonConstraints() {
        NSLayoutConstraint.activate([
            overviewButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18),
            overviewButton.widthAnchor.constraint(equalToConstant: 60),
            overviewButton.heightAnchor.constraint(equalToConstant: 20),
            overviewButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 5)
        ])
    }
    
    private func setThreatsButtonConstraints() {
        NSLayoutConstraint.activate([
            threatsButton.leadingAnchor.constraint(equalTo: overviewButton.trailingAnchor, constant: 18),
            threatsButton.widthAnchor.constraint(equalToConstant: 60),
            threatsButton.heightAnchor.constraint(equalToConstant: 20),
            threatsButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 5)
        ])
    }
    
    private func setHabitatButtonConstraints() {
        NSLayoutConstraint.activate([
            habitatButton.trailingAnchor.constraint(equalTo: galleryButton.leadingAnchor, constant: -18),
            habitatButton.widthAnchor.constraint(equalToConstant: 60),
            habitatButton.heightAnchor.constraint(equalToConstant: 20),
            habitatButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 5)
        ])
    }
    
    private func setGalleryButtonConstraints() {
        NSLayoutConstraint.activate([
            galleryButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -18),
            galleryButton.widthAnchor.constraint(equalToConstant: 60),
            galleryButton.heightAnchor.constraint(equalToConstant: 20),
            galleryButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 5)
        ])
    }
}

//MARK: -- Custom Drawing
extension InfoOptionPanelView {
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.fillColor = #colorLiteral(red: 0.2843379378, green: 0.2826535106, blue: 0.2856364548, alpha: 0.6942690497)
        shapeLayer.lineWidth = 0.0
        
        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }
        
        self.shapeLayer = shapeLayer
    }
    
    override func draw(_ rect: CGRect) {
        self.addShape()
    }
    
    func createPath() -> CGPath {
        
        let height: CGFloat = 37.0
        let path = UIBezierPath()
        let centerWidth = self.frame.width / 2
        
        path.move(to: CGPoint(x: 0, y: 0)) // Starts from top left of self
        path.addLine(to: CGPoint(x: (centerWidth - height * 2), y: 0)) // Trough beginning
        
        // First curve (going down))
        path.addCurve(to: CGPoint(x: centerWidth, y: height),
                      controlPoint1: CGPoint(x: (centerWidth - 40), y: 0), controlPoint2: CGPoint(x: centerWidth - 45, y: height))
        
        // Second curve (going up)
        path.addCurve(to: CGPoint(x: (centerWidth + height * 2), y: 0),
                      controlPoint1: CGPoint(x: centerWidth + 45, y: height), controlPoint2: CGPoint(x: (centerWidth + 40), y: 0))
        
        // Complete the rectangle
        path.addLine(to: CGPoint(x: self.frame.width, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.close()
        
        return path.cgPath
    }
}

