//
//  OnboardingViewController.swift
//  Terra
//
//  Created by Anthony Gonzalez on 9/1/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit
import AVFoundation

class OnboardingViewController: UIViewController {
    //MARK: -- UI Element Initialization
    private lazy var bodyLabel: UILabel = {
        let label = Factory.makeLabel(
            title: "By 2050, half of Earth's species may become extinct.",
            fontWeight: .medium,
            fontSize: 30,
            widthAdjustsFontSize: false,
            color: .white,
            alignment: .center)
        label.numberOfLines = 0
        label.alpha = 0
        return label
    }()
    
    private lazy var videoLayer: UIView = {
        return UIView()
    }()
    
    private lazy var darkOverlay: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.09672493488, green: 0.09615758806, blue: 0.09716594964, alpha: 0.347067637)
        return view
    }()
    
    //MARK: -- Properties
    
    private var videoLooper: AVPlayerLooper!
    
    //MARK: -- Methods
    
    private func playVideo() {
        guard let filePath = Bundle.main.path(forResource: "Dolphin", ofType: "mp4") else { return }
        let videoURL = URL(fileURLWithPath: filePath)
        
        let asset = AVAsset(url: videoURL)
        let item = AVPlayerItem(asset: asset)
        let player = AVQueuePlayer(playerItem: item)
        videoLooper = AVPlayerLooper(player: player, templateItem: item)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = view.bounds
        playerLayer.videoGravity = .resizeAspectFill
        videoLayer.layer.addSublayer(playerLayer)
        player.play()
    }
    
    private func fadeInText() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            UIView.animate(withDuration: 2.0) { [weak self] in
                guard let self = self else { return }
                self.bodyLabel.alpha = 1
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setConstraints()
        playVideo()
        fadeInText()
    }
}

//MARK: -- Add Subviews & Constraints

extension OnboardingViewController {
    func addSubviews() {
        [videoLayer, darkOverlay, bodyLabel].forEach{ view.addSubview($0) }
    }
    
    func setConstraints() {
        setVideoLayerConstraints()
        setDarkOverlayConstraints()
        setBodyLabelConstraints()
    }
    
    func setVideoLayerConstraints() {
        videoLayer.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func setDarkOverlayConstraints() {
        darkOverlay.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func setBodyLabelConstraints() {
        bodyLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(Constants.spacing)
        }
    }
}
