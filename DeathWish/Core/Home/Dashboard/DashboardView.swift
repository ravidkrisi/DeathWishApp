//
//  DashboardView.swift
//  DeathWish
//
//  Created by Ravid Krisi on 16/12/2024.
//

import SwiftUI

struct DashboardView: View {
    
    let horizontalPadding: CGFloat = 16
    let spacing: CGFloat = 20
    let rowNumItems: CGFloat = 2
    
    var itemSize: CGFloat {
        let totalSpacing = (horizontalPadding * 2) + ((rowNumItems-1) * spacing)
        let availableSpace = UIScreen.main.bounds.width - totalSpacing
        return availableSpace / rowNumItems
    }
    
    let items = [
        "item1",
        "item3",
        "item2",
        "item4",
        "item5"
    ]
    
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.fixed(itemSize), spacing: spacing),
            GridItem(.fixed(itemSize), spacing: spacing)
        ]
                  , spacing: spacing) {
            ForEach(items, id: \.self) { title in
                DashboardItemView(title: title, size: itemSize)
            }
        }
    }
}

#Preview {
    DashboardView()
}
