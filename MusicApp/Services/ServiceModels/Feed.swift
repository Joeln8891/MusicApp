//
//  Feed.swift
//  MusicApp
//
//  Created by Joel on 8/17/20.
//  Copyright © 2020 Joel. All rights reserved.
//

import Foundation

struct AlbumFeed: Codable {
    let feed: Feed?
}

struct Feed: Codable {
    let albumResults: [Album]?
    
    enum CodingKeys: String, CodingKey {
        case albumResults = "results"
    }
}

