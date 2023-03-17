//
//  LoginViewModel.swift
//  Pleny_Task
//
//  Created by Abdelrahman Salah on 17/03/2023.
//

import Foundation

class LoginViewModel: ObservableObject{
    @Published var username = ""
    @Published var password = ""
    
    @Published var hasError = false

    @Published var isSigningIn = false
    
    var canSignIn: Bool {
            !username.isEmpty && !password.isEmpty
        }
    
    func signIn() {
        guard !username.isEmpty && !password.isEmpty else {
            return
        }

        var request = URLRequest(url: URL(string: "https://dummyjson.com/auth/login")!)

        request.httpMethod = "POST"
        let body: [String: Any] = [
            "username": username,
            "password": password
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
//        request.setValue(username, forHTTPHeaderField: "username")
//        request.setValue(password, forHTTPHeaderField: "password")
        isSigningIn = true
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
               request.httpBody = jsonData
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if error != nil || (response as! HTTPURLResponse).statusCode != 200 {
                    self?.hasError = true
                } else if let data = data {
                    do {
                        let signInResponse = try JSONDecoder().decode(LoginModel.self, from: data)

                        print(signInResponse)

                        // TODO: Cache Access Token in Keychain
                    } catch {
                        print("Unable to Decode Response \(error)")
                    }
                }

                self?.isSigningIn = false
            }
        }.resume()
    }
}

