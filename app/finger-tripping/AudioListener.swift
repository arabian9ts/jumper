//
//  AudioListener.swift
//  finger-tripping
//
//  Created by 小神寛晴 on 2019/08/15.
//  Copyright © 2019 arabian9ts. All rights reserved.
//

import AVFoundation
import UIKit

class AudioListener {
    
    static let shared = AudioListener()
    var audioEngine: AVAudioEngine!
    var audioInputNode : AVAudioInputNode!
    var audioBuffer: AVAudioPCMBuffer!
    var sessionActive = false
    
    private init() {
        start()
        if sessionActive {
            installTap()
        }
    }
    
    private func installTap(){
        audioEngine = AVAudioEngine()
        audioInputNode = audioEngine.inputNode
        
        /// Sample Rate
        let frameLength = UInt32(44100)
        audioBuffer = AVAudioPCMBuffer(pcmFormat: audioInputNode.outputFormat(forBus: 0), frameCapacity: frameLength)
        audioBuffer.frameLength = frameLength
        
        audioInputNode.installTap(onBus: 0, bufferSize: frameLength, format: audioInputNode.outputFormat(forBus: 0), block: { (buffer, time) in
            
            /// We're only given 1 channel, so we need to exract that data into a normalized format
            let channels = UnsafeBufferPointer(start: buffer.floatChannelData, count: Int(buffer.format.channelCount))
            let floats = [Float](UnsafeBufferPointer(start: channels[0], count: Int(buffer.frameLength)))
            for i in 0..<Int(self.audioBuffer.frameLength) {
                guard floats.indices.contains(i) else { break }
                self.audioBuffer.floatChannelData?.pointee[i] = floats[i]
            }
        })
        try! audioEngine.start()
    }
    
    func start(){
        let audioSession = AVAudioSession.sharedInstance()
        let preferredSampleRate = 44100.0 /// Targeted default hardware rate
        let preferredIOBufferDuration = 0.01 /// 1024 / 44100 = 0.02
        
        do {
            try audioSession.setCategory(AVAudioSession.Category.record,
                                         mode: AVAudioSession.Mode.measurement,
                                         options: [])
            try audioSession.setPreferredSampleRate(preferredSampleRate)
            try audioSession.setPreferredIOBufferDuration(preferredIOBufferDuration)
            try audioSession.setActive(true)
            sessionActive = true
        } catch let error {
            print("Audio session error: \(error)")
        }
    }
    
    func stop(){
        audioEngine.inputNode.removeTap(onBus: 0)
        audioEngine.stop()
    }
}

