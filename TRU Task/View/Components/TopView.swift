//
//  TopView.swift
//  TRU Task
//
//  Created by mohamed dorgham on 25/03/2025.
//

import SwiftUI

struct TopView: View {
    var body: some View {
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
} 