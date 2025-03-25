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
    @State var prodListType = 0
    var animation: Namespace.ID
    var twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
    var oneColumnGrid = [GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            VStack (spacing: 30){
                topView
                searchBar
                productsList
            }
            .padding(30)
            .background(Color.gray.opacity(0.2))
            .edgesIgnoringSafeArea([.horizontal, .bottom])
        }
        .onAppear {
            vm.fetchProducts()
        }
        
    }
    var topView: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Hi John")
                    .font(.system(.caption, design: .rounded))
                    .fontWeight(.regular)
                    .foregroundColor(.gray)
                Text("What is your outfit Today?")
                    .font(.system(.body, design: .rounded))
                    .fontWeight(.semibold)
            }
            Spacer()
            VStack {
                Image("notification")
                    .resizable()
                    .frame(width: 20, height: 20, alignment: .center)
                    .padding(12)
            }.background(Color.white.cornerRadius(20))
        }
        
    }
    var searchBar: some View {
        VStack {
            HStack {
                Image(systemName:"magnifyingglass")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.gray)
                Text("Search product")
                    .font(.system(.caption, design: .rounded))
                    .fontWeight(.thin)
                    .foregroundColor(.gray)
                Spacer()
            }
            .padding(10)
        }
        .frame(height: 40)
        .background(Color.white.cornerRadius(20))
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
                        Button {
                            withAnimation(Animation.easeIn(duration: 0.5)) {
                                self.product = product
                                detailViewName = product.title ?? ""
                            }
                        }label: {
                            VStack {
                                VStack {
                                    ZStack (alignment: .top){
                                        AsyncImageView(
                                            url: URL(string: product.image ?? "")!,
                                            placeholder: Image(systemName: "photo"),
                                            width: .infinity, height: 70
                                        )
                                        .skeleton(with: vm.isLoading, shape: .circle)
                                        .matchedGeometryEffect(id: product.image ?? "", in: animation)
                                        .padding(8)
                                        HStack {
                                            Spacer()
                                            Image(systemName: "star.fill")
                                                .font(.system(size: 10))
                                                .foregroundColor(.yellow)
                                            Text("\(String(format: "%.1f", product.rating?.rate ?? 0))")
                                                .font(.system(.caption2, design: .rounded))
                                                .fontWeight(.thin)
                                        }
                                        .padding(8)
                                        .skeleton(with: vm.isLoading, shape: .capsule)
                                    }
                                    Spacer()
                                    HStack(alignment: .top) {
                                        VStack(alignment: .leading) {
                                            Text(product.title ?? "")
                                                .font(.system(.caption, design: .rounded))
                                                .fontWeight(.semibold)
                                                .multilineTextAlignment(.leading)
                                                .skeleton(with: vm.isLoading, shape: .capsule)
                                                .matchedGeometryEffect(id: product.title ?? "", in: animation)
                                            Text(product.category ?? "")
                                                .font(.system(.caption2, design: .rounded))
                                                .fontWeight(.light)
                                                .foregroundColor(.gray)
                                                .skeleton(with: vm.isLoading, shape: .capsule)
                                        }
                                        Spacer()
                                        Text("$\(String(format: "%.2f", product.price ?? 0))")
                                            .font(.system(.caption2, design: .rounded))
                                            .fontWeight(.medium)
                                            .skeleton(with: vm.isLoading, shape: .capsule)
                                    }
                                    .padding(.horizontal, 5)
                                }
                                .background(Color.gray.opacity(0.1).cornerRadius(12))
                            }
                            .foregroundColor(.black)
                            .padding(8)
                            .frame(height: 180)
                            .background(Color.white.cornerRadius(12).shadow(color: .gray.opacity(0.3), radius: 3, x: 0, y: 0))
                        }
                        
                    }
                    if vm.isLoading {
                        ProgressView()
                    } else {
                        Color.clear
                            .frame(height: 50)
                            .onAppear {
                                vm.fetchProducts()
                            }
                    }
                }
            }
        }
    }
}
