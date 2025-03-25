//
//  ContentView.swift
//  TRU Task
//
//  Created by mohamed dorgham on 25/03/2025.
//

import SwiftUI

struct ContentView: View {
    @Namespace var animation
    @State var detailViewName: String? = nil
    @State var product: Product? = nil
        
    var body: some View {
        ZStack {
            if (detailViewName == nil) {
                AllProductsCV(detailViewName: $detailViewName, product: $product, animation: animation)

            } else {
                ProductCV(detailViewName: $detailViewName, product: $product, animation: animation)
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
