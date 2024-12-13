//
//  SignUpView.swift
//  DeathWish
//
//  Created by Ravid Krisi on 12/12/2024.
//

import SwiftUI

@MainActor
final class SignUpViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var name: String = ""
    
    func signUp() {
        Task {
            guard let authDataResult = try await AuthenticationManager.shared.createUser(email: email, password: password) else { return }
            
            let dbUser = DBUser(id: authDataResult.uid, name: name, email: email)
            try await UsersManager.shared.addUser(user: dbUser)
        }
    }
}

struct SignUpView: View {
    
    @StateObject var vm = SignUpViewModel()
    
    var body: some View {
        VStack {
            signUpForm
        }
        .padding()
        .navigationTitle("Sign Up")
    }
}

#Preview {
    NavigationStack {
        SignUpView()
    }
}

extension SignUpView {
    var signUpForm: some View {
        VStack {
            TextField("name", text: $vm.name)
                .padding()
                .background(.gray.opacity(0.2))
                .clipShape(
                    RoundedRectangle(cornerRadius: 10)
                )
            
            TextField("email", text: $vm.email)
                .padding()
                .background(.gray.opacity(0.2))
                .clipShape(
                    RoundedRectangle(cornerRadius: 10)
                )
            
            TextField("password", text: $vm.password)
                .padding()
                .background(.gray.opacity(0.2))
                .clipShape(
                    RoundedRectangle(cornerRadius: 10)
                )
            
            Button {
                vm.signUp()
            } label: {
                Text("Sign up")
                    .foregroundStyle(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 10)
                    )
            }

        }
    }
}
