//
//  AllProductsCV.swift
//  TRU Task
//
//  Created by mohamed dorgham on 24/03/2025.
//

import SwiftUI


struct AllProductsCV: View {
    
    @ObservedObject var vm = ViewModel()
    @Binding var detailViewName: String?
    @Binding var product: Product?
    var animation: Namespace.ID
    var twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            VStack {
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
        VStack(alignment: .leading,spacing: 10) {
            Text("Special Items")
                .font(.system(.body, design: .rounded))
                .fontWeight(.heavy)
            ScrollView {
                LazyVGrid(columns: twoColumnGrid,spacing: 20) {
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
                                    }
                                    Spacer()
                                    HStack(alignment: .top) {
                                        VStack(alignment: .leading) {
                                            Text(product.title ?? "")
                                                .font(.system(.caption, design: .rounded))
                                                .fontWeight(.semibold)
                                                .multilineTextAlignment(.leading)
                                                .matchedGeometryEffect(id: product.title ?? "", in: animation)
                                            Text(product.category ?? "")
                                                .font(.system(.caption2, design: .rounded))
                                                .fontWeight(.light)
                                                .foregroundColor(.gray)
                                        }
                                        Spacer()
                                        Text("$\(String(format: "%.2f", product.price ?? 0))")
                                            .font(.system(.caption2, design: .rounded))
                                            .fontWeight(.medium)
                                    }
                                    .padding(.horizontal, 5)
                                }
                                .background(Color.gray.opacity(0.1).cornerRadius(12))
                            }
                            .padding(8)
                            .frame(height: 180)
                            .background(Color.white.cornerRadius(12).shadow(color: .gray.opacity(0.3), radius: 3, x: 0, y: 0))
                        }
                    }
                }
            }
        }
    }
}
