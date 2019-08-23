//
//  Array+.swift
//  finger-tripping
//
//  Created by arabian9ts on 2019/08/18.
//  Copyright © 2019 arabian9ts. All rights reserved.
//

import Foundation

extension Array {
    func chunks(_ chunkSize: Int) -> [[Element]] {
        return stride(from: 0, to: self.count, by: chunkSize).map {
            Array(self[$0..<Swift.min($0 + chunkSize, self.count)])
        }
    }
}
