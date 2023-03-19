//
//  Authentication.swift
//  Pleny_Task
//
//  Created by Abdelrahman Salah on 19/03/2023.
//

import SwiftUI

class Authentication: ObservableObject{
    @Published var isValidated: Bool = false
    
    func updateValidation(_ success: Bool){
        withAnimation {
            isValidated = success
        }
    }
}
