//
//  DashboardItemView.swift
//  DeathWish
//
//  Created by Ravid Krisi on 16/12/2024.
//

import SwiftUI

struct DashboardItemView: View {
    
    let title: String
    let size: CGFloat
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
        }
        .frame(width: size, height: size)
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .fill(.gray.opacity(0.2))
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    DashboardItemView(title: "favourite songs", size: 150)
        .padding()
}
