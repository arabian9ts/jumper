//
//  VRContent.swift
//  Jumper
//
//  Created by arabian9ts on 2019/08/24.
//  Copyright © 2019 arabian9ts. All rights reserved.
//

import UIKit

class VRContent {
    var title: String?
    var thumbnail: UIImage?
    var url: URL?
    
    init(title: String, thumbnail: UIImage, url: URL) {
        self.title = title
        self.thumbnail = thumbnail
        self.url = url
    }
}
