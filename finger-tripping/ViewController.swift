//
//  ViewController.swift
//  finger-tripping
//
//  Created by arabian9ts on 2019/08/14.
//  Copyright © 2019 arabian9ts. All rights reserved.
//

import UIKit
import Vision
import CoreML

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        handleOnMicSound()
    }
    
    func handleOnMicSound() {
        var srgbArray = [Double](repeating: 0.05, count: 128*128)
        
        let cgImg: CGImage = srgbArray.withUnsafeMutableBytes { (ptr) -> CGImage in
            let ctx = CGContext(
                data: ptr.baseAddress,
                width: 128,
                height: 128,
                bitsPerComponent: 8,
                bytesPerRow: 4*128,
                space: CGColorSpace(name: CGColorSpace.sRGB)!,
                bitmapInfo: CGBitmapInfo.byteOrder32Little.rawValue +
                    CGImageAlphaInfo.premultipliedFirst.rawValue
                )!
            return ctx.makeImage()!
        }
        
        let pixelBuffer: CVPixelBuffer? = toPixelBuffer(forImage: cgImg, with: CGSize(width: 299, height: 299))
        
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
    
    func toPixelBuffer(forImage image: CGImage, with frameSize: CGSize) -> CVPixelBuffer? {
        
        var pixelBuffer: CVPixelBuffer?
        
        let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(frameSize.width), Int(frameSize.height), kCVPixelFormatType_32BGRA , nil, &pixelBuffer)
        
        if status != kCVReturnSuccess {
            return nil
        }
        
        CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags.init(rawValue: 0))
        
        let data = CVPixelBufferGetBaseAddress(pixelBuffer!)
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGBitmapInfo.byteOrder32Little.rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue)
        let context = CGContext(data: data,
                                width: Int(frameSize.width),
                                height: Int(frameSize.height),
                                bitsPerComponent: 8,
                                bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!),
                                space: rgbColorSpace,
                                bitmapInfo: bitmapInfo.rawValue)
        
        context?.draw(image, in: CGRect(x: 0, y: 0, width: image.width, height: image.height))
        
        CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        
        return pixelBuffer
    }
}
