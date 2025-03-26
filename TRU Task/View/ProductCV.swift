//
//  ProductCV.swift
//  TRU Task
//
//  Created by mohamed dorgham on 25/03/2025.
//

import SwiftUI
import Shapes

struct ProductCV: View {
    @Binding var detailViewName: String?
    @Binding var product: Product?
    var animation: Namespace.ID
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack (spacing: 0){
                    productImageView
                    productDetailsView
                    Spacer()
                }
            }
            
            .ignoresSafeArea()
        }.background(
            Color.gray.opacity(0.1)
                .matchedGeometryEffect(id: "background", in: animation)
                
        )
    }
    var productImageView: some View {
        VStack {
            ZStack(alignment: .top) {
                AsyncImageView(
                    url: URL(string: product?.image ?? "")!,
                    placeholder: Image(systemName: "photo"),
                    width: .infinity, height: 300
                )
                .matchedGeometryEffect(id: product?.image ?? "", in: animation)
                .padding(8)
                HStack {
                    Button {
                        withAnimation(Animation.easeOut(duration: 0.5)) {
                            detailViewName = nil
                        }
                    }label: {
                        VStack {
                            Image("arrow")
                                .resizable()
                                .frame(width: 25, height: 25, alignment: .center)
                                .padding()
                        }.background(Color.white.cornerRadius(30).shadow(color: .gray.opacity(0.3), radius: 3, x: 0, y: 0))
                    }
                    Spacer()
                }
                .padding(.horizontal, 30)
            }
            .frame(height: UIScreen.main.bounds.height * 0.5)
            .frame(maxWidth: .infinity)
            .background(Color.white.cornerRadius(70,corners: [.bottomRight]))
        }.background(Color.gray.opacity(0.1))
            .padding(.top, 30)
    }
        var productDetailsView: some View {
            VStack (alignment: .leading, spacing: 20){
                HStack {
                    Text("\(detailViewName ?? "")")
                        .matchedGeometryEffect(id: product?.title ?? "", in: animation)
                        .font(.title3.bold())
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(Color.black)
                    Spacer()
                    Text("$\(String(format: "%.2f", product?.price ?? 0))")
                        .font(.system(.title2, design: .rounded))
                        .fontWeight(.medium)
                }
                Text(product?.category ?? "")
                    .font(.system(.caption, design: .rounded))
                    .fontWeight(.regular)
                    .foregroundStyle(Color.gray)
                Text(product?.description ?? "")
                    .font(.system(.body, design: .rounded))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(Color.gray.opacity(0.5))
                Spacer()
                actionButtons
                
            }
            .padding(30)
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.1).cornerRadius(70,corners: [.topLeft, .bottomLeft, .bottomRight]))
            
        }
        
    var actionButtons: some View {
        HStack (spacing: 20){
            VStack {
                Text("Buy Now")
                    .font(.system(.body, design: .rounded))
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.white)
                    .padding()
            }.frame(maxWidth: .infinity,maxHeight: 50)
                .background(Color.black.cornerRadius(25))
            VStack {
                Text("Add to cart")
                    .font(.system(.body, design: .rounded))
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.black)
                    .padding()
            }.frame(maxWidth: .infinity,maxHeight: 50)
                .background(Color.white.cornerRadius(25))
        }
        .padding(.bottom, 30)
    }
        
  
}

