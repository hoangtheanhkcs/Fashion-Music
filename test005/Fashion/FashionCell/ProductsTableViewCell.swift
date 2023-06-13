//
//  ProductsTableViewCell.swift
//  EcommerceUI
//
//  Created by hoang the anh on 28/05/2022.
//

import UIKit
typealias SeeAllClosure = ((_ indext: Int?) -> Void)
typealias DidSelectclosure = ((_ tableIndext: Int?, _ collectionIndex:Int?) -> Void)
class ProductsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var catagoryLable: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var index:Int?
    var onClickSeeAll:SeeAllClosure?
    var didSelectClosure:DidSelectclosure?
        
    
    var products: Product? {
        didSet {
            catagoryLable.text = products?.categoryName ?? "Category"
            collectionView.reloadData()
        }
    }
    
    func setProducts(data:Product) {
        catagoryLable.text = data.categoryName
        collectionView.reloadData()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        
                
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func buttonSeeAll(_ sender: UIButton) {
        
        onClickSeeAll?(index)
    }
    

}

extension ProductsTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products?.products?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as? ProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.productName.text = products?.products?[indexPath.row].name
        cell.img.image = UIImage(named: products?.products?[indexPath.row].imageName ?? "")
        cell.setLayout()
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
//        didSelectClosure?(index, indexPath.row)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}
