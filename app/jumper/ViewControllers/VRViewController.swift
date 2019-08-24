//
//  VRViewController.swift
//  finger-tripping
//
//  Created by arabian9ts on 2019/08/22.
//  Copyright © 2019 arabian9ts. All rights reserved.
//

import UIKit
import AVFoundation
import MetalScope

class VRViewController: StereoViewController {
    var player: AVPlayer?
    var playerLooper: Any?
    var playerObservingToken: Any?
    var audioListener: AudioListener?
    
    var playlist: Playlist?
    
    private var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        foreseeingVRStereoView()
        teleportation()
        setupPredicator()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.audioListener?.stop()
        self.timer.invalidate()
    }

//    fileprivate func foreseeingVRStereoView() {
//        if !self.playlist!.hasNext() {
//            dismiss(animated: true, completion: nil)
//        }
//        guard let url = self.playlist!.next() else { return }
//        print("change view")
//        let playerItem = AVPlayerItem(url: url)
//        let player = AVQueuePlayer(playerItem: playerItem)
//        player.play()
//        self.player = player
//    }
    
    fileprivate func teleportation() {
        if !self.playlist!.hasNext() {
            dismiss(animated: true, completion: nil)
        }
        guard let url = self.playlist!.next() else { return }
        print("change view")
        let playerItem = AVPlayerItem(url: url)
        print(url)
        let player = AVQueuePlayer(playerItem: playerItem)
        player.play()
        super.load(player, format: .stereoOverUnder)
        self.player = player
    }
    
    fileprivate func setupPredicator() {
        let audioListener = AudioListener()
        self.timer = Timer.scheduledTimer(
            timeInterval: 0.5,
            target: self,
            selector: #selector(self.soundCallback(_:)),
            userInfo: nil,
            repeats: true
        )
        audioListener.start()
        self.audioListener = audioListener
        RunLoop.current.add(timer, forMode: .common)
    }
    
    @objc private func soundCallback(_ timer: Timer) {
        if let audioListener = self.audioListener, audioListener.audioEngine.isRunning {
            let label = PredictionAPI.request.build(
                soundsArray: audioListener.audioBuffer.array()
                ).send()
            print(label)
            if label == "finger" {
//                foreseeingVRStereoView()
                teleportation()
            }
        }
        else {
            let audioListener = AudioListener()
            audioListener.start()
            self.audioListener = audioListener
        }
    }
    
}
