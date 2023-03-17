//
//  LoginModel.swift
//  Pleny_Task
//
//  Created by Abdelrahman Salah on 17/03/2023.
//

import Foundation

struct LoginModel: Decodable {

    // MARK: - Properties
    let id: Int
    let username: String
    let email: String
    let firstName:String
    let lastName: String
    let gender: String
    let image: String
    let token: String

}
