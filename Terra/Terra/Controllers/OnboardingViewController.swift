//
//  OnboardingViewController.swift
//  Terra
//
//  Created by Anthony Gonzalez on 9/1/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit
import AVFoundation
import TransitionButton

final class OnboardingViewController: UIViewController {
    //MARK: -- UI Element Initialization
    private lazy var bodyLabel: UILabel = {
        let label = Factory.makeLabel(
            title: strategy.displayedText(),
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
        let view = UIView()
        view.alpha = 0
        return view
    }()
    
    private lazy var darkOverlay: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.09672493488, green: 0.09615758806, blue: 0.09716594964, alpha: 0.4509845891)
        return view
    }()
    
    lazy var startButton: TransitionButton = {
        let button = TransitionButton()
        button.setTitle("START", for: .normal)
        button.layer.cornerRadius = 25
        button.backgroundColor = .black
        button.alpha = 0.0
        button.addTarget(self, action: #selector(startButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    //MARK: -- Properties
    private var strategy: OnboardingStrategy!
    private var videoLooper: AVPlayerLooper!
    private var audioPlayer: AVAudioPlayer?
    private lazy var isLastPage: Bool = strategy.isLastPage()
    
    //MARK: -- Methods
    
    
    @objc private func startButtonPressed(sender: TransitionButton) {
        let tabVC = RootTabBarController()
        sender.startAnimation()
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async(execute: {
            
            sleep(3) //Networking/background task done here
            
            DispatchQueue.main.async(execute: { () -> Void in
                
                sender.stopAnimation(animationStyle: .expand, completion: {
                    UIDevice.vibrate()
                    guard let window = UIApplication.shared.windows.first(where: \.isKeyWindow) else { return }
                    window.setRootViewController(tabVC, options: .init(direction: .fade, style: .easeInOut))
                })
            })
        })
    }
    
    private func playSound() {
        guard let url = Bundle.main.url(forResource: "sea", withExtension: "wav") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            
            audioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let audioPlayer = audioPlayer else { return }
            
            audioPlayer.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    private func playVideo() {
        guard let filePath = Bundle.main.path(forResource: strategy.videoFileName(), ofType: "mp4") else { return }
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
        UIView.animate(withDuration: 3.0) { [ weak self] in
            guard let self = self else { return }
            self.videoLayer.alpha = 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            UIView.animate(withDuration: 2.0) { [weak self] in
                guard let self = self else { return }
                if self.isLastPage {
                    self.startButton.alpha = 1
                }
                self.bodyLabel.alpha = 1
            }
        }
    }
    
    required init(strategy: OnboardingStrategy) {
        self.strategy = strategy
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

fileprivate extension OnboardingViewController {
    func addSubviews() {
        [videoLayer, darkOverlay, bodyLabel, startButton].forEach{ view.addSubview($0) }
    }
    
    func setConstraints() {
        setVideoLayerConstraints()
        setDarkOverlayConstraints()
        setBodyLabelConstraints()
        setStartButtonConstraints()
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
            make.edges.equalToSuperview().inset(Constants.padding)
        }
    }
    
    func setStartButtonConstraints() {
        startButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.width.equalTo(350.deviceScaled)
            make.height.equalTo(50.deviceScaled)
            make.bottom.equalToSuperview().inset(60)
        }
    }
}
