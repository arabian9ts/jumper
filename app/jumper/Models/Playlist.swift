//
//  Playlist.swift
//  Jumper
//
//  Created by arabian9ts on 2019/08/24.
//  Copyright © 2019 arabian9ts. All rights reserved.
//

import UIKit

class Playlist {
    var title: String?
    var thumbnail: UIImage?
    var contents: [VRContent?] = []
    
    private var ptr: Int = 0
    
    init(title: String, thumbnail: UIImage, contents: [VRContent]) {
        self.title = title
        self.thumbnail = thumbnail
        self.contents = contents
    }
    
    func getContentURL(at: Int) -> URL? {
        if at < self.contents.count, let content = self.contents[at] {
            return content.url
        }
        else {
            return nil
        }
    }
    
    func hasNext() -> Bool {
        return self.ptr < self.contents.count
    }
    
    func next() -> URL? {
        if hasNext() {
            let url = self.contents[self.ptr]?.url
            self.ptr += 1
            return url
        }
        else {
            return nil
        }
    }
}
