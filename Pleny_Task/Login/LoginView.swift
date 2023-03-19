//
//  LoginView.swift
//  Pleny_Task
//
//  Created by abdrahman on 16/03/2023.
//

import SwiftUI

@available(iOS 16.0, *)
struct LoginView: View {
    @EnvironmentObject var coordinator: Coordinator
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false
    @FocusState private var focusedField: Field?
    @ObservedObject var viewModel: LoginViewModel
    @EnvironmentObject var authentication: Authentication
    @ObservedObject var keyboardHeightHelper = KeyboardHeightHelper()
    @State var loginSuccess: Bool = false
    enum Field {
        case username
        case password
    }
    var body: some View {
        VStack {
            Image("loginForground")
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
                .aspectRatio(contentMode: .fit)
                .padding()
            Text("Welcome")
                .font(.system(size: 20))
                .foregroundColor(Color(hex: 0x3F3FD1))
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("User Name")
                        .font(.system(size: 15))
                        .foregroundColor(Color(hex: 0x344054))
                    TextField("Enter your name", text: $viewModel.username)
                        .frame(height: 45)
                        .focused($focusedField, equals: .username)
                        .textContentType(.givenName)
                        .padding([.leading, .trailing], 20)
                        .overlay(RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.secondary, lineWidth: 1)
                            .foregroundColor(.clear))
                }
                VStack(alignment: .leading) {
                    Text("Password")
                        .font(.system(size: 15))
                        .foregroundColor(Color(hex: 0x344054))
                    HStack {
                        Group {
                            if showPassword {
                                TextField("Enter your password", text: $viewModel.password)
                                    .focused($focusedField, equals: .password)
                                    .textContentType(.givenName)
                            }else {
                                SecureField("Enter your password", text: $viewModel.password, onCommit: {
                                    
                                })
                                .focused($focusedField, equals: .password)
                            }
                        }.frame(height: 20)
                        Button(action: {
                            showPassword.toggle()
                        }, label: {
                            Image(systemName: showPassword ? "eye.fill" : "eye.slash.fill")
                        })
                        .accentColor(.secondary)
                    }.padding()
                        .overlay(RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.secondary, lineWidth: 1)
                            .foregroundColor(.clear))
                }
            }.padding()
                .disabled(viewModel.isSigningIn)
            
            if viewModel.isSigningIn{
                ProgressView()
                    .progressViewStyle(.circular)
            }else{
                Button(action: {
                    Task {
                        await viewModel.signIn{ success in
                            authentication.updateValidation(success)
                            self.loginSuccess = success
                        }
                    }
                }) {
                    HStack{
                        Text("Sign In")
                            .font(.system(size: 15))
                            .padding()
                            .foregroundColor(.white)
                        
                            .cornerRadius(10)
                    }
                    .frame(width: UIScreen.main.bounds.width - 20, height: 46, alignment: .center)
                    .background(Color(hex: 0x3F3FD1))
                    .cornerRadius(20)
                }
            }
            
            Spacer()
        }.onTapGesture {
            if (focusedField != nil) {
                focusedField = nil
            }
        }
        .offset(y: -self.keyboardHeightHelper.keyboardHeight / 2)
        .fullScreenCover(isPresented: $loginSuccess, content: {
            NavigationView {
                coordinator.build(fullScreenCover: .tabView)
            }
        })
        .alert(isPresented: $viewModel.hasError) {
            Alert(
                title: Text("Sign In Failed"),
                message: Text("The email/password combination is invalid.")
            )
        }
    }
}
