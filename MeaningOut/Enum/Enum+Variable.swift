//
//  Enum+Variable.swift
//  MeaningOut
//
//  Created by 최대성 on 6/13/24.
//

import Foundation

enum Variable {

    static var productNameSave: String  = ""
    
    static var productName: String {
        get {
            return productNameSave
        } set {
            productNameSave = newValue
        }
    }
    
    var userLike: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "\(Variable.productName)")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "\(Variable.productName)")
        }
    }

    
    
    static var searchText: String {
        get {
            return UserDefaults.standard.string(forKey: "searchBarText") ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "searchBarText")
        }
    }
    
    
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
