//
//  Enum+Variable.swift
//  MeaningOut
//
//  Created by 최대성 on 6/13/24.
//

import Foundation

enum Variable {

    static var searchItem = ""
    static var mySearch: [ProductInfo] = []
    static var temporaryBasket: [String] = []
    
    
    
    static var myBasket: [String] {
        get {
            return UserDefaults.standard.array(forKey: "my") as? [String] ?? []
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "my")
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
    static var searchList: [String] {
        get {
            return UserDefaults.standard.stringArray(forKey: "search") ?? [""]
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "search")
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
