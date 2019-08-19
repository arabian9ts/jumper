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
    private var timer: Timer!
    
    lazy var device: MTLDevice = {
        guard let device = MTLCreateSystemDefaultDevice() else {
            fatalError("Failed to create MTLDevice")
        }
        return device
    }()
    
    weak var panoramaView: PanoramaView?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVRView()
        setupPredicator()
    }
    
    fileprivate func setupVRView() {
        let videoPath = Bundle.main.path(forResource: "resource/sample", ofType: "mp4")
        let videoURL: URL = URL(fileURLWithPath: videoPath!)
        let player = AVPlayer(url: videoURL)
        
        let panoramaView = PanoramaView(frame: view.bounds, device: self.device)
        panoramaView.load(player, format: .stereoOverUnder)
        player.play()
        self.view.addSubview(panoramaView)
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
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("Memory warning")
    }
}
