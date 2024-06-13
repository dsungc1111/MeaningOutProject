//
//  Enum+Variable.swift
//  MeaningOut
//
//  Created by 최대성 on 6/13/24.
//

import Foundation

enum Variable {
    
    static let username = "user"
    
    static var user: String {
        get {
            return UserDefaults.standard.string(forKey: username) ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: username)
        }
    }
    
    
}
