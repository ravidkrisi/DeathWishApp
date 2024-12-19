//
//  DashboardView.swift
//  DeathWish
//
//  Created by Ravid Krisi on 16/12/2024.
//

import SwiftUI

@MainActor
final class DashboardViewModel: ObservableObject {
    
    @Published var currUser: DBUser? = nil
    
    func getCurrUser() {
        Task {
            guard let authResult = AuthenticationManager.shared.getCurrentUser() else { return }
            
            let userId = authResult.uid
            guard let user = try await UsersManager.shared.getUser(userId: userId) else { return }
            self.currUser = user
        }
    }
}
struct DashboardView: View {
    
//    @StateObject var vm = DashboardViewModel()
    @Binding var user: DBUser?
    @Binding var showSignInView: Bool
    
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
        VStack {
            
            if let user {
                Text (user.id)
            }
            Button("Log Out") {
                try? AuthenticationManager.shared.signOut()
                self.user = nil
                self.showSignInView = true
            }
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
}

#Preview {
    DashboardView(user: .constant(DBUser.example), showSignInView: .constant(true))
}
