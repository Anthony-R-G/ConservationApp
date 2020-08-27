//
//  CustomCalloutView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/8/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Mapbox

final class CustomCalloutView: UIView, MGLCalloutView {
    //MARK: -- UI Element Initialization
    
    private lazy var speciesImageView: UIImageView = {
        let iv = UIImageView(frame: CGRect(
            origin: .zero,
            size: CGSize(width: 80.deviceAdjusted, height: 80.deviceAdjusted)))
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = iv.frame.size.width/2
        iv.layer.borderColor = UIColor.white.cgColor
        iv.layer.borderWidth = 2
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var titleLabel: UILabel = {
       return Factory.makeLabel(title: nil,
                                 weight: .bold,
                                 size: 17,
                                 color: Constants.Color.titleLabelColor,
                                 alignment: .left)
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = Factory.makeLabel(title: nil,
                                      weight: .regular,
                                      size: 13,
                                      color: .white,
                                      alignment: .left)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private lazy var infoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "info.circle"), for: .normal)
        button.tintColor = .systemBlue
        return button
    }()
    
  private lazy var backgroundBlurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .regular)
        let bev = UIVisualEffectView(effect: blurEffect)
        bev.frame = mainBody.bounds
        return bev
    }()
    
    
    //MARK: -- Properties
    var representedObject: MGLAnnotation
    
    // Allow the callout to remain open during panning.
    let dismissesAutomatically: Bool = false
    let isAnchoredToAnnotation: Bool = true
    
    // https://github.com/mapbox/mapbox-gl-native/issues/9228
    override var center: CGPoint {
        set {
            var newCenter = newValue
            newCenter.y -= bounds.midY
            super.center = newCenter
        }
        get {
            return super.center
        }
    }
    
    lazy var leftAccessoryView = UIView() /* unused */
    lazy var rightAccessoryView = UIView() /* unused */
    
    weak var delegate: MGLCalloutViewDelegate?
    
    let tipHeight: CGFloat = 30.0
    let tipWidth: CGFloat = 40.0
    
    let mainBody: UIButton
    
    
    //MARK: -- Methods
    
    private func setupUI(from annotation: MGLAnnotation) {
        titleLabel.text = representedObject.title ?? ""
        subtitleLabel.text = representedObject.subtitle ?? ""
        FirebaseStorageService.calloutImageManager.getImage(for: annotation.title!!, setTo: speciesImageView)
    }
    
    private func configureCalloutAppearance() {
        backgroundColor = .clear
        mainBody.backgroundColor = .clear
        mainBody.clipsToBounds = true
        mainBody.layer.cornerRadius = 10.0
    }
    
    required init(annotation: MGLAnnotation) {
        representedObject = annotation
        mainBody = UIButton(frame: CGRect(
            x: 0,
            y: -15,
            width: UIScreen.main.bounds.width * 0.60,
            height: 160.deviceAdjusted))
        
        super.init(frame: .zero)
        addSubviews()
        setConstraints()
        setupUI(from: annotation)
        configureCalloutAppearance()
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - MGLCalloutView API
    func presentCallout(from rect: CGRect, in view: UIView, constrainedTo constrainedRect: CGRect, animated: Bool) {
        
        delegate?.calloutViewWillAppear?(self)
        
        view.addSubview(self)
        
        if isCalloutTappable() {
            mainBody.addTarget(self, action: #selector(CustomCalloutView.calloutTapped), for: .touchUpInside)
        } else {
            mainBody.isUserInteractionEnabled = false
        }
        
        // Prepare our frame, adding extra space at the bottom for the tip.
        let frameWidth = mainBody.frame.size.width
        let frameHeight: CGFloat = mainBody.frame.size.height
        
        let frameOriginX = rect.origin.x + (rect.size.width/2.0) - (frameWidth/2.0)
        let frameOriginY = rect.origin.y - frameHeight
        frame = CGRect(x: frameOriginX, y: frameOriginY, width: frameWidth, height: frameHeight)
        
        if animated {
            alpha = 0
            UIView.animate(withDuration: 0.2) { [weak self] in
                guard let strongSelf = self else {
                    return
                }
                
                strongSelf.alpha = 1
                strongSelf.delegate?.calloutViewDidAppear?(strongSelf)
            }
        } else {
            delegate?.calloutViewDidAppear?(self)
        }
    }
    
    func dismissCallout(animated: Bool) {
        if (superview != nil) {
            if animated {
                UIView.animate(withDuration: 0.2, animations: { [weak self] in
                    self?.alpha = 0
                    }, completion: { [weak self] _ in
                        self?.removeFromSuperview()
                })
            } else {
                removeFromSuperview()
            }
        }
    }
    
    // MARK: - Callout interaction handlers
    
    func isCalloutTappable() -> Bool {
        if let delegate = delegate {
            if delegate.responds(to: #selector(MGLCalloutViewDelegate.calloutViewShouldHighlight)) {
                return delegate.calloutViewShouldHighlight!(self)
            }
        }
        return false
    }
    
    @objc func calloutTapped() {
        if isCalloutTappable() && delegate!.responds(to: #selector(MGLCalloutViewDelegate.calloutViewTapped)) {
            delegate!.calloutViewTapped!(self)
        }
    }
    
    // MARK: - Custom view styling
    
    override func draw(_ rect: CGRect) {
        // Draw the pointed tip at the bottom.
        let fillColor: UIColor = .darkGray
        
        let tipLeft = rect.origin.x + (rect.size.width / 2.0) - (tipWidth / 2.0)
        let tipBottom = CGPoint(x: rect.origin.x + (rect.size.width / 2.0), y: rect.origin.y + rect.size.height)
        let heightWithoutTip = rect.size.height - tipHeight - 1
        
        let currentContext = UIGraphicsGetCurrentContext()!
        
        let tipPath = CGMutablePath()
        tipPath.move(to: CGPoint(x: tipLeft, y: heightWithoutTip))
        tipPath.addLine(to: CGPoint(x: tipBottom.x, y: tipBottom.y))
        tipPath.addLine(to: CGPoint(x: tipLeft + tipWidth, y: heightWithoutTip))
        tipPath.closeSubpath()
        
        fillColor.setFill()
        currentContext.addPath(tipPath)
        currentContext.fillPath()
    }
}

//MARK: -- Add Subviews & Constraints
fileprivate extension CustomCalloutView {
    
    func addSubviews() {
        addSubview(mainBody)
        mainBody.addSubview(backgroundBlurEffectView)
    
        [speciesImageView, titleLabel, subtitleLabel, infoButton].forEach { backgroundBlurEffectView.contentView.addSubview($0) }
    }
    
    func setConstraints() {
        setSpeciesImageConstraints()
        setTitleLabelConstraints()
        setSubtitleLabelConstraints()
        setInfoButtonConstraints()
    }
    
    func setSpeciesImageConstraints() {
        speciesImageView.snp.makeConstraints { (make) in
            make.leading.top.equalTo(mainBody).inset(10)
            make.height.width.equalTo(speciesImageView.frame.size)
        }
    }
    
    func setTitleLabelConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(speciesImageView)
            make.leading.equalTo(speciesImageView.snp.trailing).offset(10)
            make.trailing.equalTo(mainBody).inset(10)
        }
    }
    
    func setSubtitleLabelConstraints() {
        subtitleLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(mainBody).inset(10)
            make.top.equalTo(speciesImageView.snp.bottom).offset(5)
            make.bottom.equalTo(mainBody.snp.bottom)
        }
    }
    
    func setInfoButtonConstraints() {
        infoButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(mainBody).inset(5)
            make.top.equalTo(mainBody).inset(5)
            make.width.height.equalTo(20)
        }
    }
}
