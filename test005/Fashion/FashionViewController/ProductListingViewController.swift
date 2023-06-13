//
//  ProductListingViewController.swift
//  EcommerceUI
//
//  Created by hoang the anh on 29/05/2022.
//

import UIKit

class ProductListingViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var productList: Product?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = productList?.categoryName
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    

  

}

extension ProductListingViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productList?.products?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTableViewCell") as? ProductDetailTableViewCell else {
            return UITableViewCell()
        }
        cell.setProductList(data: (productList?.products?[indexPath.row])!)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ProductDetailViewController") as? ProductDetailViewController else {return}
        vc.productDetail = productList?.products?[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
   
}
