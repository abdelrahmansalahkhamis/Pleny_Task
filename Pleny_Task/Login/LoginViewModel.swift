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
    @Published var isLoggedIn = false
    @Published var isSigningIn = false
    @Published private(set) var error: NetworkManager.NetworkingError?
    var canSignIn: Bool {
        !username.isEmpty && !password.isEmpty
    }
    
    func signIn(completion: @escaping(Bool)-> Void) {
        guard !username.isEmpty && !password.isEmpty else {
            return
        }
        
        var request = URLRequest(url: URL(string: "https://dummyjson.com/auth/login")!)
        
        request.httpMethod = "POST"
        let body: [String: Any] = [
            "username": username.trimmed(),
            "password": password.trimmed()
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
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
                        self?.isLoggedIn = true
                        print(signInResponse)
                        completion(self!.isLoggedIn)
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

