//
//  CachingServices.swift
//  TRU Task
//
//  Created by mohamed dorgham on 25/03/2025.
//

import Foundation
import UIKit
import CoreData

class CachingServices {
    static let shared = CachingServices()
    static let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getProducts() -> [Product]?{
        let fetchRequest: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
        do{
            let localProducts = try CachingServices.managedObjectContext.fetch(fetchRequest)
            var products: [Product] = []
            localProducts.forEach { prod in
                products.append(Product(id: Int(prod.id), title: prod.title ?? "", price: prod.price ?? 0, description: prod.desc ?? "", category: prod.category ?? "", image: prod.image ?? "", rating: Rating(rate: prod.rate ?? 0, count: 0)))
            }
            return products
        }catch{
            print(error)
            return nil
        }
    }
    func fetchLocalProducts(page: Int) -> [Product] {
          let fetchRequest: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
          fetchRequest.fetchLimit = 7
          fetchRequest.fetchOffset = page * 7
          fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)] // Sort by id

          do {
              let localProducts = try CachingServices.managedObjectContext.fetch(fetchRequest)
              var products: [Product] = []
              localProducts.forEach { prod in
                  products.append(Product(id: Int(prod.id), title: prod.title ?? "", price: prod.price ?? 0, description: prod.desc ?? "", category: prod.category ?? "", image: prod.image ?? "", rating: Rating(rate: prod.rate ?? 0, count: 0)))
              }
              return products
          } catch {
              print("Failed to fetch products: \(error)")
              return []
          }
      }
    
    func saveProductsLocal(_ products: [Product]){
        let fetchRequest: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
        do{
            let localProds = try CachingServices.managedObjectContext.fetch(fetchRequest)
            for product in products {
                if localProds.contains(where: {$0.id == Int16(product.id ?? 0)}) {
                    for prod in localProds {
                        if let itemToDelete = localProds.first(where: {$0.id == prod.id}) {
                            CachingServices.managedObjectContext.delete(itemToDelete)
                        }
                    }
                }
                let ProductEntity = ProductEntity(context: CachingServices.managedObjectContext)
                ProductEntity.id = Int16(product.id ?? 0)
                ProductEntity.title = product.title ?? ""
                ProductEntity.desc = product.description ?? ""
                ProductEntity.category = product.category ?? ""
                ProductEntity.image = product.image ?? ""
                ProductEntity.price = product.price ?? 0
                ProductEntity.rate = product.rating?.rate ?? 0
            }
            try CachingServices.managedObjectContext.save()
        }catch{
            print(error)
            
        }
    }
    
    func totalProductsCount() -> Int {
          let fetchRequest: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
          do {
              return try CachingServices.managedObjectContext.count(for: fetchRequest)
          } catch {
              print("Failed to count products: \(error)")
              return 0
          }
      }
}
