//
//  ViewController.swift
//  EcommerceUI
//
//  Created by SHUBHAM AGARWAL on 15/02/21.
//

import UIKit

class FashionViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var productData:ProductModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        loadJson()
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.estimatedRowHeight = 150
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    func loadJson() {
        guard let path = Bundle.main.path(forResource: "EcommerceJson", ofType: "json") else {return}
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
            let jsonData = try JSONSerialization.data(withJSONObject: jsonResult, options: .prettyPrinted)
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            productData = try jsonDecoder.decode(ProductModel.self, from: jsonData)
        }catch{
            print("error")
        }
        
        
    }
    func moveOnProductListing(index:Int) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ProductListingViewController") as? ProductListingViewController else {
            return
        }
        vc.productList = productData?.response?[index]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func moveOnProductDetail(tindex:Int, cindex:Int) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ProductDetailViewController") as? ProductDetailViewController else {
            return
        }
        vc.productDetail = productData?.response?[tindex].products?[cindex]
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension FashionViewController :UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productData?.response?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductsTableViewCell") as? ProductsTableViewCell else {
            return UITableViewCell()
        }
        cell.products = productData?.response?[indexPath.row]
        
        cell.index = indexPath.row
        cell.onClickSeeAll = {index in
            if let indexp = index {
                self.moveOnProductListing(index: indexp)
            }
        }
        cell.didSelectClosure = {tableIndex, collectIndex in
            if let tabIndexp = tableIndex, let cellIndexp = collectIndex {
                self.moveOnProductDetail(tindex: tabIndexp, cindex: cellIndexp)
            }
        }
        
        return cell
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}
