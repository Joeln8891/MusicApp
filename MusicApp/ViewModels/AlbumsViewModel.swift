//
//  AlbumsViewModel.swift
//  MusicApp
//
//  Created by Joel on 8/17/20.
//  Copyright © 2020 Joel. All rights reserved.
//

import Foundation

class AlbumsViewModel {
    
    var reloadTableViewClosure: (()->())?
    
    var numberOFAlbums: Int {
        return albums.count
    }
    
    private var albums = [Album]() {
        didSet {
            reloadTableViewClosure?()
        }
    }
    
    init() {
        self.getAlbums()
    }
    
    func getAlbums() {
        ServiceManager(session: URLSession.shared)
            .getTopAlbums { [weak self] (result, error) in
                if error == nil, let albums = result?.feed?.albumResults {
                    self?.albums = albums
                }
        }
    }
    
    func getAlbumData(at indexPath: IndexPath) -> Album {
        return albums[indexPath.row]
    }
}
