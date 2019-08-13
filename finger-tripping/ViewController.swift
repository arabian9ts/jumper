//
//  ViewController.swift
//  finger-tripping
//
//  Created by arabian9ts on 2019/08/14.
//  Copyright © 2019 arabian9ts. All rights reserved.
//

import UIKit
import Vision

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func handleOnMicSound() {
        let pixelBuffer: CVPixelBuffer? = nil
        
        guard let model = try? VNCoreMLModel(for: Hypre().model) else {
            return
        }
        
        let request = VNCoreMLRequest(model: model) { (request: VNRequest, error: Error?) in
            guard let results = request.results as? [VNClassificationObservation] else {
                print(error!)
                return
            }
            let topConfidence = results[0].identifier.components(separatedBy: ", ")[0]
            print("top confidence index is \(topConfidence)")
        }
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer!, options: [:]).perform([request])
    }
}
