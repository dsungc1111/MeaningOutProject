//
//  Enum+Variable.swift
//  MeaningOut
//
//  Created by 최대성 on 6/13/24.
//

import Foundation

enum Variable {

    static var index: Int {
        get {
            return UserDefaults.standard.integer(forKey: "index")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "index")
        }
    }
    
    
    
    
    static var researchList: [String] {
        get {
            return UserDefaults.standard.stringArray(forKey: "research") ?? [""]
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "research")
        }
    }
    
    static var profileImage: String {
        get {
            return UserDefaults.standard.string(forKey: Constant.saveKeyWord.profileImage.rawValue) ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: Constant.saveKeyWord.profileImage.rawValue)
        }
    }
    
    static var user: String {
        get {
            return UserDefaults.standard.string(forKey: Constant.saveKeyWord.username.rawValue) ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: Constant.saveKeyWord.username.rawValue)
        }
    }
}
