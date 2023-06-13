//
//  SubjectCollectionViewCell.swift
//  playMp3Url001
//
//  Created by hoang the anh on 02/06/2022.
//

import UIKit

class SubjectCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionImage: UIImageView!
    
    @IBOutlet weak var collectionSubjectLable: UILabel!
    
    func setLayerCollectionCell() {
        self.layer.borderWidth = 0.3
        self.layer.borderColor = UIColor.brown.cgColor
        self.layer.cornerRadius = 20
    }
    
}
