//
//  SongViewController.swift
//  MusicApp
//
//  Created by Joel on 8/20/20.
//  Copyright © 2020 Joel. All rights reserved.
//

import UIKit

class SongViewController: UIViewController {
    
    var songViewModel: SongViewModel?
    
    private var albumNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var artistNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var albumImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var genreLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var copyRightLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let navigateToiTunesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Open in iTunes", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    init(_ songViewModel: SongViewModel?) {
        self.songViewModel = songViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setUpViews()
        self.configureViews()
    }
    
    private func setUpViews() {
        self.infoStackView.addArrangedSubview(albumNameLabel)
        self.infoStackView.addArrangedSubview(artistNameLabel)
        self.infoStackView.addArrangedSubview(albumImage)
        self.infoStackView.addArrangedSubview(genreLabel)
        self.infoStackView.addArrangedSubview(releaseDateLabel)
        self.infoStackView.addArrangedSubview(copyRightLabel)
        self.infoStackView.addArrangedSubview(UIView())
        
        self.view.addSubview(infoStackView)
        self.view.addSubview(navigateToiTunesButton)

        NSLayoutConstraint.activate([
            self.infoStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide .topAnchor, constant: 20),
            self.infoStackView.bottomAnchor.constraint(equalTo: self.navigateToiTunesButton.topAnchor, constant: 10),
            self.infoStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            self.infoStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            self.navigateToiTunesButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            self.navigateToiTunesButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            self.navigateToiTunesButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
    }
    
    private func configureViews() {
        guard let model = self.songViewModel?.song else { return }
        albumNameLabel.text = model.albumName ?? ""
        artistNameLabel.text = model.artistName ?? ""
        albumImage.load(url: model.albumImageUrl ?? "")
        genreLabel.text = self.songViewModel?.genereLabel
        releaseDateLabel.text = self.songViewModel?.releaseDate
        copyRightLabel.text = model.copyright
        navigateToiTunesButton.addTarget(self, action: #selector(self.buttonNavigationAction), for: .touchUpInside)
    }
    
    @objc
    private func buttonNavigationAction(sender: UIButton) {
        self.songViewModel?.navigateToItunes()
    }
}
