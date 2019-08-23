//
//  VRMovieQueue.swift
//  finger-tripping
//
//  Created by arabian9ts on 2019/08/22.
//  Copyright © 2019 arabian9ts. All rights reserved.
//

import Foundation

class VRMovieQueue {
    static let shared = VRMovieQueue()
    private var urlQueue: [String] = []
    private let movies: [String : String] = [
        "AngelFalls": "https://hack-u-fukuoka-2019.s3-ap-northeast-1.amazonaws.com/Angel_Falls.mp4",
        "CanaimaLagoon": "https://hack-u-fukuoka-2019.s3-ap-northeast-1.amazonaws.com/Canaima_Lagoon.mp4",
        "Congo1": "https://hack-u-fukuoka-2019.s3-ap-northeast-1.amazonaws.com/Congo_1.mp4",
        "Congo2": "https://hack-u-fukuoka-2019.s3-ap-northeast-1.amazonaws.com/Congo_2.mp4",
        "Italy": "https://hack-u-fukuoka-2019.s3-ap-northeast-1.amazonaws.com/Italy.mp4",
        "Macao": "https://hack-u-fukuoka-2019.s3-ap-northeast-1.amazonaws.com/Macao.mp4",
        "Marmots": "https://hack-u-fukuoka-2019.s3-ap-northeast-1.amazonaws.com/Marmots.mp4",
        "MontMaudit": "https://hack-u-fukuoka-2019.s3-ap-northeast-1.amazonaws.com/Mont_Maudit.mp4",
        "Moscow": "https://hack-u-fukuoka-2019.s3-ap-northeast-1.amazonaws.com/Moscow.mp4",
        "Russia": "https://hack-u-fukuoka-2019.s3-ap-northeast-1.amazonaws.com/Russia.mp4",
        "Switzerland": "https://hack-u-fukuoka-2019.s3-ap-northeast-1.amazonaws.com/Switzerland.mp4"
    ]
    
    private init() {}
    
    public func queuing() {
        self.urlQueue = self.movies.values.shuffled()
    }
    
    public func next() -> URL {
        let urlString = self.urlQueue.popLast()!
        self.urlQueue.insert(urlString, at: 0)

        return URL(string: urlString)!
    }
}
