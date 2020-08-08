import Mapbox

class CustomCalloutView: UIView, MGLCalloutView {
    //MARK: -- UI Element Initialization
    
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
        iv.isUserInteractionEnabled = false
        mainBody.insertSubview(iv, at: 0)
        return iv
    }()
    
    private lazy var blackBar: UIView = {
        let bar = UIView()
        bar.backgroundColor = .black
        bar.clipsToBounds = true
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.isUserInteractionEnabled = false
        return bar
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
    
    required init(annotation: SpeciesAnnotation) {
        self.representedObject = annotation
        self.mainBody = UIButton(frame: CGRect(x: 0, y: -15, width: UIScreen.main.bounds.width * 0.75, height: 180))
      
        super.init(frame: .zero)
        
        backgroundColor = .clear
        
        mainBody.backgroundColor = .black
        mainBody.tintColor = .white
        mainBody.clipsToBounds = true
        mainBody.layer.cornerRadius = 10.0
        
        addSubview(mainBody)
        addSubviews()
        setConstraints()
        
        titleLabel.text = self.representedObject.title ?? ""
        subtitleLabel.text = self.representedObject.subtitle ?? ""
        FirebaseStorageService.cellImageManager.getImage(for: annotation.title!, setTo: backgroundImageView)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - MGLCalloutView API
    func presentCallout(from rect: CGRect, in view: UIView, constrainedTo constrainedRect: CGRect, animated: Bool) {
        
        delegate?.calloutViewWillAppear?(self)
        
        view.addSubview(self)
        
        // Prepare title label.
        //        mainBody.setTitle(representedObject.title!, for: .normal)
        
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
                guard let self = self else {
                    return
                }
                self.alpha = 1
                self.delegate?.calloutViewDidAppear?(self)
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
        let fillColor: UIColor = .black
        
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
        let UIElements = [blackBar, titleLabel, subtitleLabel]
        UIElements.forEach { mainBody.addSubview($0) }
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
            titleLabel.leadingAnchor.constraint(equalTo: mainBody.leadingAnchor, constant: Constants.universalLeadingConstant),
            titleLabel.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: 5),
            titleLabel.widthAnchor.constraint(equalTo: mainBody.widthAnchor),
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
            backgroundImageView.leadingAnchor.constraint(equalTo: mainBody.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: mainBody.trailingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: mainBody.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: blackBar.topAnchor)
        ])
    }
    
    func setBlackBarConstraints() {
        NSLayoutConstraint.activate([
            blackBar.leadingAnchor.constraint(equalTo: mainBody.leadingAnchor),
            blackBar.trailingAnchor.constraint(equalTo: mainBody.trailingAnchor),
            blackBar.bottomAnchor.constraint(equalTo: mainBody.bottomAnchor),
            blackBar.heightAnchor.constraint(equalTo: mainBody.heightAnchor, multiplier: 0.4)
        ])
    }
}
