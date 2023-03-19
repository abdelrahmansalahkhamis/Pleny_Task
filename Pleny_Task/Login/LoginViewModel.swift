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
    
//    func signIn() async {
//        guard !username.isEmpty && !password.isEmpty else {
//            return
//        }
//        let body: [String: Any] = [
//            "username": username,
//            "password": password
//        ]
//        let jsonData = try? JSONSerialization.data(withJSONObject: body)
//        do{
//
//            let response = try await NetworkManager.shared.request(.login(credintials: jsonData))
////            let response = try await NetworkManager.shared.request(.login(credintials: jsonData), ofType: LoginModel.self)
//            print("response = \(response)")
//        }catch{
//            self.hasError = true
//            if let networkingError = error as? NetworkManager.NetworkingError {
//                self.error = networkingError
//            } else {
//                self.error = .custom(error: error)
//            }
//        }




//        var request = URLRequest(url: URL(string: "https://dummyjson.com/auth/login")!)
//
//        request.httpMethod = "POST"
//
////        request.setValue(username, forHTTPHeaderField: "username")
////        request.setValue(password, forHTTPHeaderField: "password")
//        isSigningIn = true
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//               request.httpBody = jsonData
//        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
//            DispatchQueue.main.async {
//                if error != nil || (response as! HTTPURLResponse).statusCode != 200 {
//                    self?.hasError = true
//                } else if let data = data {
//                    do {
//                        let signInResponse = try JSONDecoder().decode(LoginModel.self, from: data)
//
//                        print(signInResponse)
//
//                        // TODO: Cache Access Token in Keychain
//                    } catch {
//                        print("Unable to Decode Response \(error)")
//                    }
//                }
//
//                self?.isSigningIn = false
//            }
//        }.resume()
//    }
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

