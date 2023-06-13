//
//  AlbumTableViewCell.swift
//  playMp304
//
//  Created by hoang the anh on 27/04/2022.
//

import Foundation
import UIKit

final class AlbumTableViewCell : UITableViewCell {
    
    var album:Album! {
        didSet {
            if let album = album {
                albumCover.image = album.image
                albumName.text = album.name
                songsCount.text = "\(album.songs.count) songs"
            }
        }
    }
    
    
    private lazy var albumCover: UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.contentMode = .scaleAspectFill
        v.clipsToBounds = true
        v.layer.cornerRadius = 25
        v.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        
        return v
    }()
    
    private lazy var albumName:UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = .systemFont(ofSize: 18, weight: .bold)
        v.textColor = UIColor(named: "titleColor")
        return v
    }()
    private lazy var songsCount:UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = .systemFont(ofSize: 14, weight: .medium)
        v.numberOfLines = 0
        v.textColor = UIColor(named: "subTitleColor")
        
        return v
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        [albumCover, albumName, songsCount].forEach { v in
            contentView.addSubview(v)
        }
        
        
        setupViewConstrains()
        
    }
    
    private func setupViewConstrains() {
        //albumcover
        NSLayoutConstraint.activate([albumCover.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16), albumCover.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16), albumCover.widthAnchor.constraint(equalToConstant: 100), albumCover.heightAnchor.constraint(equalToConstant: 100), albumCover.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)])
        
        //album name
        NSLayoutConstraint.activate([albumName.leadingAnchor.constraint(equalTo: albumCover.trailingAnchor, constant: 16), albumName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16), albumName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16) ])
        
        //songs count
        NSLayoutConstraint.activate([songsCount.leadingAnchor.constraint(equalTo: albumCover.trailingAnchor, constant: 16), songsCount.topAnchor.constraint(equalTo: albumName.bottomAnchor, constant: 8), songsCount.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16), songsCount.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16) ])
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
