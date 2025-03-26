//
//  ProductCardView.swift
//  TRU Task
//
//  Created by mohamed dorgham on 25/03/2025.
//

import SwiftUI
import SkeletonUI

struct ProductCardView: View {
    let product: Product
    let isLoading: Bool
    let animation: Namespace.ID
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack {
                VStack {
                    ZStack (alignment: .top){
                        AsyncImageView(
                            url: URL(string: product.image ?? "")!,
                            placeholder: Image(systemName: "photo"),
                            width: .infinity, height: 70
                        )
                        .skeleton(with: isLoading, shape: .circle)
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
                        .skeleton(with: isLoading, shape: .capsule)
                    }
                    Spacer()
                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            Text(product.title ?? "")
                                .font(.system(.caption, design: .rounded))
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.leading)
                                .skeleton(with: isLoading, shape: .capsule)
                                .matchedGeometryEffect(id: product.title ?? "", in: animation)
                            Text(product.category ?? "")
                                .font(.system(.caption2, design: .rounded))
                                .fontWeight(.light)
                                .foregroundColor(.gray)
                                .skeleton(with: isLoading, shape: .capsule)
                        }
                        Spacer()
                        Text("$\(String(format: "%.2f", product.price ?? 0))")
                            .font(.system(.caption2, design: .rounded))
                            .fontWeight(.medium)
                            .skeleton(with: isLoading, shape: .capsule)
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
} 