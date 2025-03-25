//
//  ProductsModel.swift
//  TRU Task
//
//  Created by mohamed dorgham on 25/03/2025.
//

import Foundation

// MARK: - BrandsResponseElement
struct Product: Codable {
    var id: Int?
    var title: String?
    var price: Double?
    var description: String?
    var category: String?
    var image: String?
    var rating: Rating?
}


// MARK: - Rating
struct Rating: Codable {
    var rate: Double?
    var count: Int?
}
