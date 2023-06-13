//
//  ProductDetailTableViewCell.swift
//  EcommerceUI
//
//  Created by hoang the anh on 29/05/2022.
//

import UIKit

class ProductDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var productPrice: UILabel!
    
    @IBOutlet weak var productDescription: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setProductList(data:ProductDetails) {
        productName.text = data.name
        productPrice.text = data.price
        productDescription.text = data.description
        productImage.image = UIImage(named: data.imageName!)
    }
}
