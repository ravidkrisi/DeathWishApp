//
//  SignInView.swift
//  DeathWish
//
//  Created by Ravid Krisi on 12/12/2024.
//

import SwiftUI
import FirebaseAuth

@MainActor
final class SignInViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    func signIn() {
        Task {
            try await AuthenticationManager.shared.signIn(email: email, password: password)
            print("sign In successfully")
        }
    }
}

struct SignInView: View {
    
    @Binding var showSignInView: Bool
    
    @StateObject var vm = SignInViewModel()
    
    var body: some View {
        VStack {
            signInForm
        }
        .padding()
        .navigationTitle("Sign In")
        .onAppear {
            try? Auth.auth().signOut()
        }
    }
}

#Preview {
    NavigationStack {
        SignInView(showSignInView: .constant(true))
    }
}

extension SignInView {
    var signInForm: some View {
        VStack {
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
                vm.signIn()
                showSignInView = false
            } label: {
                Text("Sign In")
                    .foregroundStyle(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 10)
                    )
            }
            
            NavigationLink("Sign Up") {
                SignUpView(showSignInView: $showSignInView)
            }
        }
    }
}
