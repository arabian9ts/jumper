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
    
    @IBOutlet weak var tripButton: UIButton! {
        didSet {
            self.tripButton.layer.borderWidth = 2.0
            self.tripButton.layer.borderColor = #colorLiteral(red: 0.3397541344, green: 0.1627097428, blue: 1, alpha: 1)
            self.tripButton.layer.cornerRadius = 10.0
        }
    }
    
    @IBAction func tripButtonTapped(_ sender: UIButton) {
        presentStereoView(from: 0)
    }
    
    private var playlistNameView: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupPlaylistCoverView()
        setupPlaylistContentsView()
        setupParallaxOffset()
        setupContentsViewLayout()
        setupPlaylistNameView()
        setNewPlaylistNameView()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var shouldAutorotate: Bool {
        get {
            return false
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .portrait
        }
    }
    
    private func setupPlaylistCoverView() {
        let coverViewSize = self.playlistContentsView.bounds.size
        let coverWidth = coverViewSize.width * 0.7
        let coverHeight = coverViewSize.height * 0.4
        self.playlistCoverView.itemSize = CGSize(width: coverWidth, height: coverHeight)
        self.playlistCoverView.delegate = self
        self.playlistCoverView.dataSource = self
        self.playlistCoverView.isInfinite = true
        self.playlistCoverView.interitemSpacing = coverWidth / 2
        self.playlistCoverView.transformer = FSPagerViewTransformer(type: .coverFlow)
    }
    
    private func setupPlaylistContentsView() {
        self.playlistContentsView.delegate = self
        self.playlistContentsView.dataSource = self
    }
    
    private func presentStereoView(from: Int) {
        let introView = UILabel()
        introView.text = "Place your phone into your Cardboard viewer."
        introView.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        introView.textAlignment = .center
        introView.backgroundColor = #colorLiteral(red: 0.2745098039, green: 0.3529411765, blue: 0.3921568627, alpha: 1)
        
        let vrViewController = VRViewController(device: device)
        vrViewController.introductionView = introView
        
        let playlistIndex = self.playlistCoverView.currentIndex
        let playlist = PlaylistMock.shared.playlists[playlistIndex]
        guard let title = playlist.title, let thumbnail = playlist.thumbnail else { return }
        
        let suffixSize = playlist.contents.count - from
        let newContents = Array(playlist.contents.suffix(suffixSize)) as! [VRContent]
        vrViewController.playlist = Playlist(title: title, thumbnail: thumbnail, contents: newContents)
        present(vrViewController, animated: true, completion: nil)
    }
    
    private func setupParallaxOffset() {
        for index in self.playlistContentsView.indexPathsForVisibleRows! {
            let contentCell = self.playlistContentsView.cellForRow(at: index) as? PlaylistContentsViewCell
            guard let cell = contentCell else { continue }
            let rect = self.playlistContentsView.rectForRow(at: index)
            let rectInTable = self.playlistContentsView.convert(rect, to: self.playlistContentsView.superview)
            let offset = rectInTable.origin.y + rectInTable.height / 2
            let percentage = offset / self.playlistContentsView.bounds.height
            var imageRect = cell.contentImageView.frame
            imageRect.origin.y = percentage * 65 * -1
            cell.contentImageView.frame = imageRect
        }
    }
    
    private func setupContentsViewLayout() {
        self.playlistContentsView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        self.playlistContentsView.setContentOffset(CGPoint(x: 0, y: 5), animated: true)
    }
    
    private func setupPlaylistNameView() {
        let playlistNameView = newPlaylistNameView()
        playlistNameView.text = PlaylistMock.shared.playlists[0].title
        self.playlistNameView = playlistNameView
    }
    
    private func newPlaylistNameView() -> UILabel {
        let coverSize = self.playlistCoverView.bounds.size
        let playlistNameView = UILabel(frame: CGRect(x: 30, y: coverSize.height - 50, width: coverSize.width - 60, height: 30))
        playlistNameView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        playlistNameView.alpha = 0
        playlistNameView.layer.masksToBounds = true
        playlistNameView.layer.cornerRadius = 15
        playlistNameView.textAlignment = .center
        return playlistNameView
    }
    
    private func setNewPlaylistNameView() {
        let playlistNameView = newPlaylistNameView()
        let playlistIndex = self.playlistCoverView.currentIndex
        playlistNameView.text = PlaylistMock.shared.playlists[playlistIndex].title
        self.playlistNameView = playlistNameView
        UIView.transition(
            with: self.playlistCoverView,
            duration: 0.36,
            animations: {
                playlistNameView.alpha = 0.75
                self.playlistCoverView.addSubview(playlistNameView)},
            completion: nil)
    }
}

extension ViewController: FSPagerViewDataSource, FSPagerViewDelegate {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return PlaylistMock.shared.playlists.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "CoverCell", at: index)
        cell.contentView.layer.shadowOpacity = 0.4
        cell.contentView.layer.opacity = 0.86
        
        let playlist = PlaylistMock.shared.playlists[index]
        cell.imageView?.image = playlist.thumbnail
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
    }
    
    func pagerViewWillBeginDragging(_ pagerView: FSPagerView) {
        if let playlistNameView = self.playlistNameView {
            UIView.transition(
                with: self.playlistCoverView,
                duration: 0.36,
                animations: {
                    playlistNameView.alpha = 0.0
                    playlistNameView.removeFromSuperview()},
                completion: nil)
        }
    }
    
    func pagerViewDidEndDecelerating(_ pagerView: FSPagerView) {
        setNewPlaylistNameView()
        self.playlistContentsView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .clear
    }
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        view.tintColor = .clear
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaylistContentsViewCell", for: indexPath) as! PlaylistContentsViewCell
        let playlistIndex = self.playlistCoverView.currentIndex
        let content = PlaylistMock.shared.playlists[playlistIndex].contents[indexPath.section]
        if let title = content?.title, let image = content?.thumbnail {
            cell.setupCell(title: title, image: image)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let screenWidth = UIScreen.main.bounds.size.width
        return (screenWidth * 0.5) / 2
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        setupParallaxOffset()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentStereoView(from: indexPath.section)
    }
}
