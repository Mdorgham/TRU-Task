//
//  AllProductsVM.swift
//  TRU Task
//
//  Created by mohamed dorgham on 25/03/2025.
//

import Foundation
import Alamofire

extension AllProductsCV {
    class ViewModel: ObservableObject {
        @Published var products: [Product] = []
        
        
        func fetchProducts() {
             AF.request("https://fakestoreapi.com/products")
                 .responseDecodable(of: [Product].self) { response in
                     switch response.result {
                     case .success(let products):
                         self.products = products
                     case .failure(let error):
                         print(error.localizedDescription)
                     }
                 }
         }
        
        
    }
}
