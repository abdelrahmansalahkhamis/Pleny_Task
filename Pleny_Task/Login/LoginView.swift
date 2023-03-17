//
//  LoginView.swift
//  Pleny_Task
//
//  Created by abdrahman on 16/03/2023.
//

import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false
    @FocusState private var focusedField: Field?
    @ObservedObject var viewModel: LoginViewModel
    enum Field {
        case username
        case password
    }
    var body: some View {
        VStack {
            Image("loginForground")
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
                .aspectRatio(contentMode: .fill)
            Text("Welcome")
                .font(.system(size: 20))
                .foregroundColor(Color(hex: 0x3F3FD1))
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("User Name")
                        .font(.system(size: 15))
                        .foregroundColor(Color(hex: 0x344054))
                    TextField("Enter your name", text: $viewModel.username)
                        .frame(height: 55)
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
                                SecureField("Enter your password", text: $viewModel.password, onCommit: {
                                    
                                })
                                .focused($focusedField, equals: .password)
                            }else {
                                TextField("Enter your password", text: $viewModel.password)
                                    .focused($focusedField, equals: .password)
                                    .textContentType(.givenName)
                            }
                        }.frame(height: 30)
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
                    viewModel.signIn()
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
        .alert(isPresented: $viewModel.hasError) {
                    Alert(
                        title: Text("Sign In Failed"),
                        message: Text("The email/password combination is invalid.")
                    )
                }
    }
}

extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}
