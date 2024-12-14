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
    @Published var birthDate: Date = .now
    
    @Published var isSignedUp: Bool = false
    
    func signUp() {
        Task {
            guard let authDataResult = try await AuthenticationManager.shared.createUser(email: email, password: password) else { return }
            
            let dbUser = DBUser(id: authDataResult.uid, name: name, email: email, dateOfBirth: birthDate)
            try await UsersManager.shared.addUser(user: dbUser)
            
            isSignedUp = true
            print("created user successfully")
        }
    }
}

struct SignUpView: View {
    
    @Binding var showSignInView: Bool
    
    @StateObject var vm = SignUpViewModel()
    
    var body: some View {
            VStack {
                signUpForm
            }
            .navigationDestination(isPresented: $vm.isSignedUp, destination: {
                HomeView(showSignInView: $showSignInView)
            })
            .padding()
            .navigationTitle("Sign Up")
    }
}

#Preview {
    NavigationStack {
        SignUpView(showSignInView: .constant(true))
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
            
            DatePicker("Date Of Birth", selection: $vm.birthDate, displayedComponents: [.date])
                .datePickerStyle(.compact)
            
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
                showSignInView = false
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
