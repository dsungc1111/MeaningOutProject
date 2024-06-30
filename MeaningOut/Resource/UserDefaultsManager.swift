//
//  UserDefaultsManager.swift
//  MeaningOut
//
//  Created by 최대성 on 6/18/24.
//

import Foundation


struct UserDefaultManager {
    
    static var myBasket: [String] {
        get {
            return UserDefaults.standard.stringArray(forKey: SaveKeyWord.myBasket.rawValue) ?? []
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: SaveKeyWord.myBasket.rawValue)
        }
    }
    static func appendInMyBasket(productId: String, like: Bool) {
        var basket = myBasket
        
        if like {
            if !basket.contains(productId) {
                basket.append(productId)
            }
        } else {
            for i in 0..<basket.count {
                if basket[i] == productId {
                    basket.remove(at: i)
                    break
                }
            }
        }
        
        myBasket = basket
    }
    
    
    static var index: Int {
        get {
            return UserDefaults.standard.integer(forKey: SaveKeyWord.index.rawValue)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: SaveKeyWord.index.rawValue)
        }
    }
    static var searchList: [String] {
        get {
            return UserDefaults.standard.stringArray(forKey: SaveKeyWord.search.rawValue) ?? []
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: SaveKeyWord.search.rawValue)
        }
    }
    static var searchText: String {
        get {
            return UserDefaults.standard.string(forKey: SaveKeyWord.searchBarText.rawValue) ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: SaveKeyWord.searchBarText.rawValue)
        }
    }
    
    static var profileImage: String {
        get {
            return UserDefaults.standard.string(forKey: SaveKeyWord.profileImage.rawValue) ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: SaveKeyWord.profileImage.rawValue)
        }
    }
    static var user: String {
        get {
            return UserDefaults.standard.string(forKey: SaveKeyWord.username.rawValue) ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: SaveKeyWord.username.rawValue)
        }
    }
    
    static var signInTime: String {
        get {
            return UserDefaults.standard.string(forKey: SaveKeyWord.signInTime.rawValue) ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: SaveKeyWord.signInTime.rawValue)
        }
    }
}
