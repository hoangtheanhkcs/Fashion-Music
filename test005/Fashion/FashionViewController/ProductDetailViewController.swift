//
//  ProductDetailViewController.swift
//  EcommerceUI
//
//  Created by hoang the anh on 29/05/2022.
//

import UIKit

class ProductDetailViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var productDetail: ProductDetails?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.title = productDetail?.name
      
    }
    


}

extension ProductDetailViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTableViewCell") as? ProductDetailTableViewCell else {
            return UITableViewCell()
        }
        cell.setProductList(data: productDetail!)
        return cell
    }
}
