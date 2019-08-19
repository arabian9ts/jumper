//
//  PredictionAPI.swift
//  finger-tripping
//
//  Created by arabian9ts on 2019/08/19.
//  Copyright © 2019 arabian9ts. All rights reserved.
//

import AVFoundation
import Foundation

class PredictionAPI {
    static let request = PredictionAPI()
    
    private var grpcClient: Prediction_PredictionServiceServiceClient
    private var chunkRequests: [Prediction_PredictRequest]
    private var predicatedlabel: SoundLabel = "none"
    
    private init() {
        self.grpcClient = Prediction_PredictionServiceServiceClient(
            address: "192.168.0.5:50051",
            secure: false
        )
        self.chunkRequests = []
    }
    
    func build(soundsArray: [Float]) -> PredictionAPI {
        self.chunkRequests = []
        let sounds = soundsArray.chunks(23000)
        for sound in sounds {
            var req = Prediction_PredictRequest()
            req.sounds = sound
            self.chunkRequests.append(req)
        }
        return self
    }
    
    func send() -> SoundLabel {
        do {
            let stream = try self.grpcClient.predict(completion: nil)
            for req in self.chunkRequests {
                try stream.send(req) { error in
                    if let error = error {
                        print("Send Stream Request Failed: \(error)")
                    }
                }
            }
            
            try stream.closeAndReceive() { res in
                if let result = res.result {
                    self.predicatedlabel = result.label
                }
            }
        } catch {
            print("Prediction Request Failed: \(error)")
        }
        return self.predicatedlabel
    }
}

typealias SoundLabel = String
