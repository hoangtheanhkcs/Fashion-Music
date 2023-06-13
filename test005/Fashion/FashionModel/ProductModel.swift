//
//  ProductModel.swift
//  EcommerceUI
//
//  Created by hoang the anh on 28/05/2022.
//

import Foundation

struct ProductModel:Codable {
    var response:[Product]?
}
struct Product:Codable {
    
    var categoryName:String?
    var products: [ProductDetails]?
    
//    private enum CodingKeys: String, CodingKey {
//        case catagoryName = "category_name"
//        case products
//    }
}
struct ProductDetails:Codable {
    var name:String?
    var imageName:String?
    var price:String?
    var description:String?
}
