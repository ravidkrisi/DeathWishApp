//
//  ProfileView.swift
//  DeathWish
//
//  Created by Ravid Krisi on 23/12/2024.
//

import SwiftUI

final class ProfileViewModel: ObservableObject {
    
    func logout() {
        do {
            try AuthenticationManager.shared.signOut()
        } catch {
            print("failed logging out")
            print(error)
        }
    }
}

struct ProfileView: View {
    
    @State var vm = ProfileViewModel()
    
    @Binding var currUser: DBUser?
    @Binding var showSignInView: Bool
    
    var body: some View {
        List {
            userDetailsSection
            functionsSection
        }
    }
}

#Preview {
    NavigationStack {
        ProfileView(currUser: .constant(DBUser.example), showSignInView: .constant(false))
    }
}

extension ProfileView {
    var userDetailsSection: some View {
        Section("Account details") {
            VStack(alignment: .leading) {
                Text("Name")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(currUser?.name ?? "")
                    .font(.headline)
            }
            
            VStack(alignment: .leading) {
                Text("Email")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(currUser?.email ?? "")
                    .font(.headline)
            }
            
            VStack(alignment: .leading) {
                Text("Date of Birth")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(currUser?.dateOfBirth?.formatted(date: .numeric, time: .omitted) ?? "")
                    .font(.headline)
            }
        }
    }
    
    var functionsSection: some View {
        Section {
            Button("Log Out", role: .destructive) {
                vm.logout()
                showSignInView = true
                currUser = nil
            }
        }
    }
}
