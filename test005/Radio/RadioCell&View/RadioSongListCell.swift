//
//  ListCell.swift
//  playMp304
//
//  Created by hoang the anh on 30/04/2022.
//

import Foundation
import UIKit

final class ListCell:UITableViewCell {
    
//    var song:Song! {
//        didSet {
//            songName.text = song.name
//            
//        }
//    }
    
    var songName:UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = .systemFont(ofSize: 18, weight: .bold)
//        v.textColor = UIColor(named: "titleColor")
        v.textColor = .white
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
        addSubview(songName)
        self.backgroundColor = .darkGray
        setupConstrains()
    }
    private func setupConstrains() {
        NSLayoutConstraint.activate([
            songName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            songName.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
