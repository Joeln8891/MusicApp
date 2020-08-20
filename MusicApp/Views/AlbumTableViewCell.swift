//
//  AlbumTableViewCell.swift
//  MusicApp
//
//  Created by Joel on 8/17/20.
//  Copyright © 2020 Joel. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    
    private var albumNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var artistNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
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
    
    private let labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let imgLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.viewSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)
    }
    
    func configureWithModel(_ model: Album) {
        self.albumNameLabel.text = model.albumName ?? ""
        self.artistNameLabel.text = model.artistName ?? ""
        self.albumImage.load(url: model.albumImageUrl ?? "")
        
    }
    
    private func viewSetup() {
        self.labelsStackView.addArrangedSubview(albumNameLabel)
        self.labelsStackView.addArrangedSubview(artistNameLabel)
        self.imgLabelStackView.addArrangedSubview(albumImage)
        self.imgLabelStackView.addArrangedSubview(labelsStackView)
        self.albumImage.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        self.labelsStackView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        self.contentView.addSubview(imgLabelStackView)
        
        self.albumImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.albumImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        NSLayoutConstraint.activate([
            self.imgLabelStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            self.imgLabelStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
            self.imgLabelStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            self.imgLabelStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10)
        ])
    }
    
}
