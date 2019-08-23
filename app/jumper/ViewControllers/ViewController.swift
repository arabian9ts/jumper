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
    
    @IBOutlet weak var playListCollection: UICollectionView!
    
    lazy var device: MTLDevice = {
        guard let device = MTLCreateSystemDefaultDevice() else {
            fatalError("Failed to create MTLDevice")
        }
        return device
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupVRView()
        //        setupPredicator()
        setupPlayListCollection()
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        presentStereoView()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    fileprivate func setupPlayListCollection() {
        self.playListCollection.delegate = self
        self.playListCollection.dataSource = self
        let nib = UINib(nibName: "PlayListCell", bundle: Bundle.main)
        self.playListCollection.register(nib, forCellWithReuseIdentifier: "PlayListCell")
        
        let layout = UICollectionViewFlowLayout()
        let width: CGFloat = UIScreen.main.bounds.width * 2 / 5
        let height = width + 20
        layout.itemSize = CGSize(width: width, height: height)
        
        let space = width / 3
        print(space)
        layout.sectionInset = UIEdgeInsets(top: space / 2, left: space / 2, bottom: space, right: space / 2)
        layout.minimumLineSpacing = space / 2
        layout.minimumInteritemSpacing = 0
        
        self.playListCollection.collectionViewLayout = layout
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

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayListCell", for: indexPath)
        return cell
    }
}

//extension ViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width: CGFloat = UIScreen.main.bounds.width / 3
//        let height = width
//        return CGSize(width: width, height: height)
//    }
//}
