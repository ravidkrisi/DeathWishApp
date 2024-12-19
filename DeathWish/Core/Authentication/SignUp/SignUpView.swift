//
//  SignUpView.swift
//  DeathWish
//
//  Created by Ravid Krisi on 12/12/2024.
//

import SwiftUI

@MainActor
final class SignUpViewModel: ObservableObject {
    
    @Published var email: String = "" {
        didSet { validateEmail() }
    }
    @Published var password: String = "" {
        didSet { validatePassword() }
    }
    @Published var name: String = ""
    @Published var birthDate: Date = .now
    
    @Published var isEmailValid: Bool = false
    @Published var isPasswordValid: Bool = false
    
    private func validateEmail() {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        isEmailValid = NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    private func validatePassword() {
        isPasswordValid = password.count >= 6
    }
    
    @Published var isSignedUp: Bool = false
    
    func signUp() async throws -> DBUser? {
        guard let authDataResult = try await AuthenticationManager.shared.createUser(email: email, password: password) else { return nil }
        
        let dbUser = DBUser(id: authDataResult.uid, name: name, email: email, dateOfBirth: birthDate)
        try await UsersManager.shared.addUser(user: dbUser)
        
        isSignedUp = true
        print("created user successfully")
        
        return try await UsersManager.shared.getUser(userId: authDataResult.uid)
    }
}

struct SignUpView: View {
    
    @Binding var showSignInView: Bool
    @Binding var currUser: DBUser?
    
    @StateObject var vm = SignUpViewModel()
    
    var body: some View {
            VStack {
                signUpForm
            }
            .navigationDestination(isPresented: $vm.isSignedUp, destination: {
                DashboardView(user: $currUser, showSignInView: $showSignInView)
            })
            .padding()
            .navigationTitle("Sign Up")
    }
}

#Preview {
    NavigationStack {
        SignUpView(showSignInView: .constant(true), currUser: .constant(DBUser.example))
    }
}

extension SignUpView {
    var signUpForm: some View {
        VStack {
            // name
            TextField("name", text: $vm.name)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .padding()
                .background(.gray.opacity(0.2))
                .clipShape(
                    RoundedRectangle(cornerRadius: 10)
                )
            
            // date of birth
            DatePicker("Date Of Birth", selection: $vm.birthDate, displayedComponents: [.date])
                .datePickerStyle(.compact)
            
            // email
            TextField("email", text: $vm.email)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .padding()
                .background(vm.isEmailValid || vm.email.isEmpty ? .gray.opacity(0.2) : .red.opacity(0.2))
                .clipShape(
                    RoundedRectangle(cornerRadius: 10)
                )
            
            // password
            SecureField("password", text: $vm.password)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .padding()
                .background(vm.isPasswordValid || vm.password.isEmpty ? .gray.opacity(0.2) : .red.opacity(0.2))
                .clipShape(
                    RoundedRectangle(cornerRadius: 10)
                )
            
            Button {
                Task {
                    self.currUser = try await vm.signUp()
                }
                showSignInView = false
            } label: {
                Text("Sign up")
                    .foregroundStyle(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(vm.isEmailValid && vm.isPasswordValid ? .blue : .blue.opacity(0.5))
                    .clipShape(
                        RoundedRectangle(cornerRadius: 10)
                    )
            }

        }
    }
}
