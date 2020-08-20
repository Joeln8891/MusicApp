//
//  SongViewModel.swift
//  MusicApp
//
//  Created by Joel on 8/20/20.
//  Copyright © 2020 Joel. All rights reserved.
//

import Foundation
import UIKit


class SongViewModel {
     var song: Album?
    
    init(song: Album?) {
        self.song = song
    }
    
    var genereLabel: String {
        return self.song?.genres.compactMap { $0.name }.joined(separator: ", ") ?? ""
    }
    
    var releaseDate: String {
       return formatSongReleaseDate()
    }
    
    private func formatSongReleaseDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let formatedDate = dateFormatter.date(from: self.song?.releaseDate ?? "No Date") {
            dateFormatter.dateFormat = "MMM d, yyyy"
            return dateFormatter.string(from: formatedDate)
        }
        return ""
    }
    
    func navigateToItunes() {
        if let url = URL(string: song?.url ?? "") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

