//
//  Artists.swift
//  MusicApp
//
//  Created by Joel on 8/17/20.
//  Copyright © 2020 Joel. All rights reserved.
//

import Foundation

struct Album: Decodable {
    let artistName: String?
    let releaseDate: String?
    let albumName: String?
    let copyright: String?
    let albumImageUrl: String?
    let genres: [Genre]
    let url: String?
}

extension Album {
    enum CodingKeys: String, CodingKey {
        case artistName
        case releaseDate
        case albumName = "name"
        case copyright
        case albumImageUrl = "artworkUrl100"
        case genres
        case url
    }
}

struct Genre: Decodable {
    let name: String?
}
