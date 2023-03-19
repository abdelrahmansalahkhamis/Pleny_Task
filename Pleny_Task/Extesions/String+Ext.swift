//
//  String+Ext.swift
//  Pleny_Task
//
//  Created by Abdelrahman Salah on 19/03/2023.
//

import Foundation

extension String{
    func trimmed() -> String{
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
