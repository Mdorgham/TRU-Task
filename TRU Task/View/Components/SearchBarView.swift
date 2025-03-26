//
//  SearchBarView.swift
//  TRU Task
//
//  Created by mohamed dorgham on 25/03/2025.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName:"magnifyingglass")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.gray)
                TextField("Search product", text: $searchText)
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
} 