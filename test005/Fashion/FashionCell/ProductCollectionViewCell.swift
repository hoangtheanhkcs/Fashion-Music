//
//  ProductCollectionViewCell.swift
//  EcommerceUI
//
//  Created by hoang the anh on 28/05/2022.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var productName: UILabel!
    
    func setLayout() {
        img.layer.cornerRadius = 15
        img.layer.borderWidth = 0.3
        img.layer.borderColor = UIColor.gray.cgColor
    }
}

  
  
