//
//  ViewController.swift
//  MusicApp
//
//  Created by Joel on 8/17/20.
//  Copyright © 2020 Joel. All rights reserved.
//

import UIKit

class AlbumsViewController: UIViewController {
    
    lazy var viewModel = AlbumsViewModel()
    
   private let albumsTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(AlbumTableViewCell.self, forCellReuseIdentifier: "albumCell")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Top 100 Albums"
        self.view.backgroundColor = .white
        self.view = albumsTableView
        self.setUpViews()
        self.viewModel.reloadTableViewClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.albumsTableView.reloadData()
            }
        }
    }
    
    private func setUpViews() {
        albumsTableView.delegate = self
        albumsTableView.dataSource = self
    }


}

extension AlbumsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOFAlbums
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath) as? AlbumTableViewCell else {
            fatalError("Unable to find Album cell")
        }
        let album = self.viewModel.getAlbumData(at: indexPath)
        cell.configureWithModel(album)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let album = self.viewModel.getAlbumData(at: indexPath)
        let songViewModel = SongViewModel(song: album)
        let songViewController = SongViewController(songViewModel)
        self.navigationController?.pushViewController(songViewController, animated: true)
    }
    
    
}

