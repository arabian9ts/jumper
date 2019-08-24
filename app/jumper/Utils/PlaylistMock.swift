//
//  PlaylistMock.swift
//  Jumper
//
//  Created by arabian9ts on 2019/08/24.
//  Copyright © 2019 arabian9ts. All rights reserved.
//

import UIKit

class PlaylistMock {
    static let shared: PlaylistMock = PlaylistMock()
    private init() {}
    
    let playlists: [Playlist] = [
        Playlist(
            title: "大都会巡回シリーズ",
            thumbnail: UIImage(named: "urban")!,
            contents: [
                VRContent(
                    title: "Tokyo Night Fever",
                    thumbnail: UIImage(named: "urban")!,
                    url: URL(string: "https://hack-u-fukuoka-2019.s3-ap-northeast-1.amazonaws.com/Angel_Falls.mp4")!),
                VRContent(
                    title: "Electorical Night Party",
                    thumbnail: UIImage(named: "urban2")!,
                    url: URL(string: "https://hack-u-fukuoka-2019.s3-ap-northeast-1.amazonaws.com/Canaima_Lagoon.mp4")!),
                VRContent(
                    title: "Growthing Country",
                    thumbnail: UIImage(named: "urban3")!,
                    url: URL(string: "https://hack-u-fukuoka-2019.s3-ap-northeast-1.amazonaws.com/Switzerland.mp4")!),
                VRContent(
                    title: "Nagasaki Mt.Inasa",
                    thumbnail: UIImage(named: "urban4")!,
                    url: URL(string: "https://hack-u-fukuoka-2019.s3-ap-northeast-1.amazonaws.com/Russia.mp4")!),
                VRContent(
                    title: "New York Don't Sleep",
                    thumbnail: UIImage(named: "urban5")!,
                    url: URL(string: "https://hack-u-fukuoka-2019.s3-ap-northeast-1.amazonaws.com/Italy.mp4")!),
            ]),
        Playlist(
            title: "本当に出たお化け屋敷",
            thumbnail: UIImage(named: "horror")!,
            contents: [
                VRContent(
                    title: "Tokyo Night Fever",
                    thumbnail: UIImage(named: "horror")!,
                    url: URL(string: "https://hack-u-fukuoka-2019.s3-ap-northeast-1.amazonaws.com/Angel_Falls.mp4")!),
                VRContent(
                    title: "Tokyo Night Fever",
                    thumbnail: UIImage(named: "horror2")!,
                    url: URL(string: "https://hack-u-fukuoka-2019.s3-ap-northeast-1.amazonaws.com/Angel_Falls.mp4")!),
                VRContent(
                    title: "Tokyo Night Fever",
                    thumbnail: UIImage(named: "horror3")!,
                    url: URL(string: "https://hack-u-fukuoka-2019.s3-ap-northeast-1.amazonaws.com/Angel_Falls.mp4")!),
                VRContent(
                    title: "Tokyo Night Fever",
                    thumbnail: UIImage(named: "horror4")!,
                    url: URL(string: "https://hack-u-fukuoka-2019.s3-ap-northeast-1.amazonaws.com/Angel_Falls.mp4")!),
                VRContent(
                    title: "Tokyo Night Fever",
                    thumbnail: UIImage(named: "horror4")!,
                    url: URL(string: "https://hack-u-fukuoka-2019.s3-ap-northeast-1.amazonaws.com/Angel_Falls.mp4")!),
            ]),
        Playlist(
            title: "年中いつでも海水浴",
            thumbnail: UIImage(named: "sea")!,
            contents: [
                VRContent(
                    title: "Okinawa Sea",
                    thumbnail: UIImage(named: "sea")!,
                    url: URL(string: "https://hack-u-fukuoka-2019.s3-ap-northeast-1.amazonaws.com/Angel_Falls.mp4")!),
                VRContent(
                    title: "Summer Time !!",
                    thumbnail: UIImage(named: "sea2")!,
                    url: URL(string: "https://hack-u-fukuoka-2019.s3-ap-northeast-1.amazonaws.com/Angel_Falls.mp4")!),
                VRContent(
                    title: "Beach Itary",
                    thumbnail: UIImage(named: "sea3")!,
                    url: URL(string: "https://hack-u-fukuoka-2019.s3-ap-northeast-1.amazonaws.com/Angel_Falls.mp4")!),
                VRContent(
                    title: "Tokyo Night Fever",
                    thumbnail: UIImage(named: "sea4")!,
                    url: URL(string: "https://hack-u-fukuoka-2019.s3-ap-northeast-1.amazonaws.com/Angel_Falls.mp4")!),
                VRContent(
                    title: "Tokyo Night Fever",
                    thumbnail: UIImage(named: "sea5")!,
                    url: URL(string: "https://hack-u-fukuoka-2019.s3-ap-northeast-1.amazonaws.com/Angel_Falls.mp4")!),
            ]),
        Playlist(
            title: "自然に癒やされたいだけの人生だった",
            thumbnail: UIImage(named: "nature")!,
            contents: [
                VRContent(
                    title: "Tokyo Night Fever",
                    thumbnail: UIImage(named: "urban")!,
                    url: URL(string: "https://hack-u-fukuoka-2019.s3-ap-northeast-1.amazonaws.com/Angel_Falls.mp4")!),
                VRContent(
                    title: "Tokyo Night Fever",
                    thumbnail: UIImage(named: "urban")!,
                    url: URL(string: "https://hack-u-fukuoka-2019.s3-ap-northeast-1.amazonaws.com/Angel_Falls.mp4")!),
                VRContent(
                    title: "Tokyo Night Fever",
                    thumbnail: UIImage(named: "urban")!,
                    url: URL(string: "https://hack-u-fukuoka-2019.s3-ap-northeast-1.amazonaws.com/Angel_Falls.mp4")!),
                VRContent(
                    title: "Tokyo Night Fever",
                    thumbnail: UIImage(named: "urban")!,
                    url: URL(string: "https://hack-u-fukuoka-2019.s3-ap-northeast-1.amazonaws.com/Angel_Falls.mp4")!),
                VRContent(
                    title: "Tokyo Night Fever",
                    thumbnail: UIImage(named: "urban")!,
                    url: URL(string: "https://hack-u-fukuoka-2019.s3-ap-northeast-1.amazonaws.com/Angel_Falls.mp4")!),
            ]),
        Playlist(
            title: "世界遺産メドレー",
            thumbnail: UIImage(named: "world_view")!,
            contents: [
                VRContent(
                    title: "Tokyo Night Fever",
                    thumbnail: UIImage(named: "urban")!,
                    url: URL(string: "https://hack-u-fukuoka-2019.s3-ap-northeast-1.amazonaws.com/Angel_Falls.mp4")!),
                VRContent(
                    title: "Tokyo Night Fever",
                    thumbnail: UIImage(named: "urban")!,
                    url: URL(string: "https://hack-u-fukuoka-2019.s3-ap-northeast-1.amazonaws.com/Angel_Falls.mp4")!),
                VRContent(
                    title: "Tokyo Night Fever",
                    thumbnail: UIImage(named: "urban")!,
                    url: URL(string: "https://hack-u-fukuoka-2019.s3-ap-northeast-1.amazonaws.com/Angel_Falls.mp4")!),
                VRContent(
                    title: "Tokyo Night Fever",
                    thumbnail: UIImage(named: "urban")!,
                    url: URL(string: "https://hack-u-fukuoka-2019.s3-ap-northeast-1.amazonaws.com/Angel_Falls.mp4")!),
                VRContent(
                    title: "Tokyo Night Fever",
                    thumbnail: UIImage(named: "urban")!,
                    url: URL(string: "https://hack-u-fukuoka-2019.s3-ap-northeast-1.amazonaws.com/Angel_Falls.mp4")!),
            ]),
    ]
}
