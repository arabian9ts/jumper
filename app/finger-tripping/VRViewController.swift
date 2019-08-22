//
//  VRViewController.swift
//  finger-tripping
//
//  Created by arabian9ts on 2019/08/14.
//  Copyright © 2019 arabian9ts. All rights reserved.
//

import UIKit
import MetalScope
import AVFoundation

class VRViewController: UIViewController {
    private var currentView: StereoView?
    private var nextView: StereoView?
    private var timer: Timer!
    
    lazy var device: MTLDevice = {
        guard let device = MTLCreateSystemDefaultDevice() else {
            fatalError("Failed to create MTLDevice")
        }
        return device
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVRView()
        //        setupPredicator()
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
        self.foreseeingVRStereoView()
        self.teleportation()
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("Memory warning")
    }
}
