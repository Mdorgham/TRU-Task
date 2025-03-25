//
//  ImageView.swift
//  TRU Task
//
//  Created by mohamed dorgham on 25/03/2025.
//

import Foundation
import SwiftUI

// Reusable AsyncImageView component
struct AsyncImageView: View {
    let url: URL
    let placeholder: Image?
    let width: CGFloat
    let height: CGFloat
    
    @State private var imageData: Data? = nil
    
    var body: some View {
        VStack {
            if let imageData = imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: width, height: height)
            } else {
                placeholder?
                    .resizable()
                    .scaledToFit()
                    .frame(width: width, height: height)
                    .onAppear {
                        loadImage()
                    } // Load the image on appearance
            }
        }
    }
    
    private func loadImage() {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data, error == nil {
                DispatchQueue.main.async {
                    self.imageData = data
                }
            }
        }.resume()
    }
}
