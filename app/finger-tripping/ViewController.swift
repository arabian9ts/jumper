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
        self.timer = Timer.scheduledTimer(timeInterval: 2.0,
                                          target: self,
                                          selector: #selector(self.judgeSound(_:)),
                                          userInfo: nil,
                                          repeats: true)
        self.timer?.fire()
        // Do any additional setup after loading the view.
    }
    
    @objc func judgeSound(_ timer: Timer) {
        guard (audioEngine != nil) else { return }
        if AudioListener.default.audioEngine.isRunning {
            
            print(AudioListener.default.audioBuffer.array())
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("Memory warning")
    }
}

