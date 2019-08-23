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

class ViewController: UIViewController {
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
        presentStereoView()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    fileprivate func setupVRView() {
        VRMovieQueue.shared.queuing()
        //        self.foreseeingVRStereoView()
        //        self.teleportation()
    }
    
    func presentStereoView() {
        let introView = UILabel()
        introView.text = "Place your phone into your Cardboard viewer."
        introView.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        introView.textAlignment = .center
        introView.backgroundColor = #colorLiteral(red: 0.2745098039, green: 0.3529411765, blue: 0.3921568627, alpha: 1)
        
        let vrViewController = VRViewController(device: device)
        vrViewController.introductionView = introView
        present(vrViewController, animated: true, completion: nil)
    }
}
