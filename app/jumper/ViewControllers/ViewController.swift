//
//  ViewController.swift
//  finger-tripping
//
//  Created by arabian9ts on 2019/08/14.
//  Copyright © 2019 arabian9ts. All rights reserved.
//

import UIKit
import SceneKit
import FSPagerView

class ViewController: UIViewController {
    
    @IBOutlet weak var playlistCoverView: FSPagerView! {
        didSet {
            self.playlistCoverView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "CoverCell")
        }
    }
    
    lazy var device: MTLDevice = {
        guard let device = MTLCreateSystemDefaultDevice() else {
            fatalError("Failed to create MTLDevice")
        }
        return device
    }()
    
    @IBOutlet weak var playlistContentsView: UITableView! {
        didSet {
            let nib = UINib(nibName: "PlaylistContentsViewCell", bundle: Bundle.main)
            self.playlistContentsView.register(nib, forCellReuseIdentifier: "PlaylistContentsViewCell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlaylistCoverView()
        setupPlaylistContentsView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupParallaxOffset()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func setupPlaylistCoverView() {
        self.playlistCoverView.delegate = self
        self.playlistCoverView.dataSource = self
        self.playlistCoverView.isInfinite = true
        self.playlistCoverView.itemSize = CGSize(width: 240, height: 160)
        self.playlistCoverView.interitemSpacing = 16
        self.playlistCoverView.transformer = FSPagerViewTransformer(type: .coverFlow)
    }
    
    fileprivate func setupPlaylistContentsView() {
        self.playlistContentsView.delegate = self
        self.playlistContentsView.dataSource = self
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
    
    func setupParallaxOffset() {
        for index in self.playlistContentsView.indexPathsForVisibleRows! {
            let cell = self.playlistContentsView.cellForRow(at: index) as! PlaylistContentsViewCell
            let rect = self.playlistContentsView.rectForRow(at: index)
            let rectInTable = self.playlistContentsView.convert(rect, to: self.playlistContentsView.superview)
            let offset = rectInTable.origin.y + rectInTable.height / 2
            let percentage = offset / self.playlistContentsView.bounds.height
            var imageRect = cell.contentImageView.frame
            imageRect.origin.y = percentage * 60 * -1
            cell.contentImageView.frame = imageRect
        }
    }
}

extension ViewController: FSPagerViewDataSource, FSPagerViewDelegate {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return 10
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "CoverCell", at: index)
//        let coverflow = coverflowContents[index]
        
        cell.contentView.layer.shadowOpacity = 0.4
        cell.contentView.layer.opacity = 0.86
        
        cell.imageView?.image = UIImage(named: "urban")
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaylistContentsViewCell", for: indexPath) as! PlaylistContentsViewCell
        cell.setupCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let screenWidth = UIScreen.main.bounds.size.width
        return (screenWidth * 0.9) / 2
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        setupParallaxOffset()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
        print(indexPath.section)
    }
}
