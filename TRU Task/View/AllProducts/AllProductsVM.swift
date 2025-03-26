//
//  AllProductsVM.swift
//  TRU Task
//
//  Created by mohamed dorgham on 25/03/2025.
//

import Foundation
import Alamofire
import CoreData

extension AllProductsCV {
    class ViewModel: ObservableObject {
        @Published var products: [Product] = []
        @Published var isLoading = false
        private var currentPage = 0
        private var totalProductCount = 0
        

        /// - Fetches total product count from local database
        /// - If internet connection is available, fetches data from server
        init() {
            totalProductCount = getTotalProductsCount()
            if ConnectionManager.shared().isConnected {
                self.fetchLiveProducts()
            }else {
                self.fetchLocalProducts()
            }
        }

        /// Fetch products from server via API
        /// - Saves products to local database
        func fetchLiveProducts() {
             AF.request("https://fakestoreapi.com/products")
                 .responseDecodable(of: [Product].self) { response in
                     switch response.result {
                     case .success(let products):
                         self.products = products
                         CachingServices.shared.saveProductsLocal(products)
                     case .failure(let error):
                         print(error.localizedDescription)
                     }
                 }
         }
        
        /// Fetch products from local database
        /// - Fetches 7 products at a time
        /// - Checks for no ongoing loading and more products to fetch
        /// - Converts data from Entity to Product model
        func fetchLocalProducts() {
            guard !isLoading, products.count < totalProductCount else { return }
            isLoading = true

            let fetchRequest: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
            fetchRequest.fetchLimit = 7
            fetchRequest.fetchOffset = currentPage * 7
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]

            do {
                let newProducts = try CachingServices.managedObjectContext.fetch(fetchRequest)
                DispatchQueue.main.async {
                    newProducts.forEach { prod in
                        self.products.append(Product(id: Int(prod.id), title: prod.title ?? "", price: prod.price ?? 0, description: prod.desc ?? "", category: prod.category ?? "", image: prod.image ?? "", rating: Rating(rate: prod.rate ?? 0, count: 0)))
                    }
                    self.currentPage += 1
                    self.isLoading = false
                }
            } catch {
                print("Error fetching products: \(error)")
                isLoading = false
            }
        }
        
        /// Get total number of products in local database
        /// - Returns the count of products stored in CoreData
        private func getTotalProductsCount() -> Int {
              let fetchRequest: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
              return (try? CachingServices.managedObjectContext.count(for: fetchRequest)) ?? 0
          }
        
    }
}
