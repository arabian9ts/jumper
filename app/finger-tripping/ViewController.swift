//
//  ViewController.swift
//  finger-tripping
//
//  Created by arabian9ts on 2019/08/14.
//  Copyright © 2019 arabian9ts. All rights reserved.
//

import AVFoundation
import UIKit

class ViewController: UIViewController {
    
    var audioEngine: AudioListener? = nil
    var engine = AVAudioEngine()
    var timer: Timer!
    let client = Prediction_PredictionServiceServiceClient(address: "192.168.0.5:50051", secure: false)
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if var engine = audioEngine {
            if engine.audioEngine.isRunning == false {
                engine = AudioListener()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioEngine = AudioListener()
        self.timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(self.judgeSound(_:)),
            userInfo: nil,
            repeats: true
        )
        self.timer?.fire()
    }
    
    @objc func judgeSound(_ timer: Timer) {
        guard (audioEngine != nil) else { return }
        if AudioListener.default.audioEngine.isRunning {
            do {
                let stream = try client.predict(completion: nil)
                let sounds = AudioListener.default.audioBuffer.array().chunks(23000)
                var headRequest = Prediction_PredictRequest()
                var tailRequest = Prediction_PredictRequest()
                headRequest.sounds = sounds[0]
                tailRequest.sounds = sounds[1]
                try stream.send(headRequest) { error in
                    if let error = error {
                        print(error)
                    }
                }
                try stream.send(tailRequest) { error in
                    if let error = error {
                        print(error)
                    }
                }
                try stream.closeAndReceive() { res in
                    print("Response: \(String(describing: res.result?.label))")
                }
            } catch {
                print(error)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("Memory warning")
    }
}

