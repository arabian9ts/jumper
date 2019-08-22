//
//  ViewController.swift
//  finger-tripping
//
//  Created by arabian9ts on 2019/08/14.
//  Copyright © 2019 arabian9ts. All rights reserved.
//

import UIKit
import SceneKit
import MetalScope
import AVFoundation

class ViewController: UIViewController, SceneLoadable {
    private weak var stereoView: StereoView?
    private weak var panoramaView: PanoramaView?
    
    open var scene: SCNScene? {
        didSet {
            stereoView?.scene = scene
        }
    }
    
    open var stereoParameters: StereoParametersProtocol = StereoParameters() {
        didSet {
            stereoView?.stereoParameters = stereoParameters
        }
    }
    
    private var currentView: StereoView?
    private var nextView: StereoView?
    private var timer: Timer!
    
    lazy var device: MTLDevice = {
        guard let device = MTLCreateSystemDefaultDevice() else {
            fatalError("Failed to create MTLDevice")
        }
        return device
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVRView()
        //        setupPredicator()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        panoramaView?.isPlaying = true
        presentStereoView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        panoramaView?.isPlaying = false
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        panoramaView?.updateInterfaceOrientation(with: coordinator)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    fileprivate func foreseeingVRStereoView() {
        let videoURL: URL = VRMovieQueue.shared.next()
        let player = AVPlayer(url: videoURL)
        let stereoView = StereoView(device: self.device, maximumTextureSize: self.view.bounds.size)
        stereoView.load(player, format: .stereoOverUnder)
        player.play()
        self.nextView = stereoView
    }
    
    fileprivate func teleportation() {
        if let currentView = self.currentView {
            currentView.removeFromSuperview()
        }
        if let nextView = self.nextView {
            self.view.addSubview(nextView)
            self.currentView = nextView
            self.foreseeingVRStereoView()
        }
    }
    
    fileprivate func setupVRView() {
        VRMovieQueue.shared.queuing()
        loadPanoramaView()
        loadVideo()
        //        self.foreseeingVRStereoView()
        //        self.teleportation()
    }
    
    fileprivate func setupPredicator() {
        self.timer = Timer.scheduledTimer(
            timeInterval: 0.5,
            target: self,
            selector: #selector(self.soundCallback(_:)),
            userInfo: nil,
            repeats: true
        )
        RunLoop.current.add(timer, forMode: .default)
    }
    
    @objc private func soundCallback(_ timer: Timer) {
        if AudioListener.shared.audioEngine.isRunning {
            let label = PredictionAPI.request.build(
                soundsArray: AudioListener.shared.audioBuffer.array()
                ).send()
            print(label)
            if label == "finger" {
                teleportation()
            }
        }
    }
    
    var player: AVPlayer?
    var playerLooper: Any?
    var playerObservingToken: Any?
    
    deinit {
        if let token = playerObservingToken {
            NotificationCenter.default.removeObserver(token)
        }
    }
    
    private func loadPanoramaView() {
        let panoramaView = PanoramaView(frame: view.bounds, device: device)
        panoramaView.setNeedsResetRotation()
        panoramaView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(panoramaView)
        
        // fill parent view
        let constraints: [NSLayoutConstraint] = [
            panoramaView.topAnchor.constraint(equalTo: view.topAnchor),
            panoramaView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            panoramaView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            panoramaView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
        self.panoramaView = panoramaView
    }
    
    private func loadVideo() {
        let url = VRMovieQueue.shared.next()
        let playerItem = AVPlayerItem(url: url)
        let player = AVQueuePlayer(playerItem: playerItem)
        
        panoramaView?.load(player, format: .stereoOverUnder)
        
        self.player = player
        
        // loop
        if #available(iOS 10, *) {
            playerLooper = AVPlayerLooper(player: player, templateItem: playerItem)
        } else {
            player.actionAtItemEnd = .none
            playerObservingToken = NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: playerItem, queue: nil) { _ in
                player.seek(to: CMTime.zero, toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)
            }
        }
        
        player.play()
    }
    
    func presentStereoView() {
        let introView = UILabel()
        introView.text = "Place your phone into your Cardboard viewer."
        introView.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        introView.textAlignment = .center
        introView.backgroundColor = #colorLiteral(red: 0.2745098039, green: 0.3529411765, blue: 0.3921568627, alpha: 1)
        
        let stereoViewController = StereoViewController(device: device)
        stereoViewController.introductionView = introView
        stereoViewController.scene = panoramaView?.scene
        present(stereoViewController, animated: true, completion: nil)
    }
}
