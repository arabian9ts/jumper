//
//  PlaylistContentsViewCell.swift
//  Jumper
//
//  Created by arabian9ts on 2019/08/24.
//  Copyright © 2019 arabian9ts. All rights reserved.
//

import UIKit

class PlaylistContentsViewCell: UITableViewCell {

    @IBOutlet weak var contentImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame = newFrame
            let newWidth = frame.width * 0.90
            let space = (frame.width - newWidth) / 2
            frame.size.width = newWidth
            frame.origin.x += space
            super.frame = frame
        }
    }

    func setupCell() {
        let coverImage = UIImage(named: "nature")
        guard let image = coverImage else {
            return
        }
        filterWithDark(image: image)
    }
    
    private func filterWithDark(image: UIImage) {
        let frame = CGRect(origin:CGPoint(x: 0, y: 0), size: image.size)
        let tempView = UIView(frame: frame)
        tempView.backgroundColor = UIColor.black
        tempView.alpha = 0.5
        
        UIGraphicsBeginImageContext(frame.size)
        let context = UIGraphicsGetCurrentContext()
        image.draw(in: frame)
        
        context!.translateBy(x: 0, y: frame.size.height)
        context!.scaleBy(x: 1.0, y: -1.0)
        context!.clip(to: frame, mask: image.cgImage!)
        tempView.layer.render(in: context!)
        
        let imageRef = context!.makeImage()
        let filteredImage = UIImage(cgImage: imageRef!)
        UIGraphicsEndImageContext()
        
        self.contentImageView.image = filteredImage
    }
    
}
