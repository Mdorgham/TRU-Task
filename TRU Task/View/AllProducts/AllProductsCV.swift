//
//  AllProductsCV.swift
//  TRU Task
//
//  Created by mohamed dorgham on 24/03/2025.
//

import SwiftUI
import SkeletonUI

struct AllProductsCV: View {
    
    @ObservedObject var vm = ViewModel()
    @Binding var detailViewName: String?
    @Binding var product: Product?
    @State var prodListType = 1
    @State var searchText = ""
    var animation: Namespace.ID
    var twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
    var oneColumnGrid = [GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            VStack (spacing: 30){
                TopView()
                SearchBarView(searchText: $searchText)
                productsList
            }
            .padding(30)
            .background(Color.gray.opacity(0.2))
            .edgesIgnoringSafeArea([.horizontal, .bottom])
        }
        .onAppear {
            
        }
    }
    
    var productsList: some View {
        VStack(alignment: .leading,spacing: 20) {
            HStack {
                Text("Special Items")
                    .font(.system(.body, design: .rounded))
                    .fontWeight(.heavy)
                Spacer()
                Button {
                    if prodListType == 0 {
                        prodListType = 1
                    }else {
                        prodListType = 0
                    }
                }label: {
                    Image(systemName: prodListType == 0 ? "rectangle.grid.1x2.fill" : "square.grid.2x2.fill")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                }
            }
            ScrollView {
                LazyVGrid(columns: prodListType == 0 ? twoColumnGrid : oneColumnGrid,spacing: 20) {
                    ForEach(vm.products, id: \.id) { product in
                        ProductCardView(
                            product: product,
                            isLoading: vm.isLoading,
                            animation: animation
                        ) {
                            withAnimation(Animation.easeIn(duration: 0.5)) {
                                self.product = product
                                detailViewName = product.title ?? ""
                            }
                        }
                    }
                    if vm.isLoading {
                        ProgressView()
                    } else {
                        Color.clear
                            .frame(height: 50)
                            .onAppear {
                                vm.fetchLocalProducts()
                            }
                    }
                }
            }
        }
    }
}
