//
//  Enum+Constant.swift
//  MeaningOut
//
//  Created by 최대성 on 6/13/24.
//

import Foundation

enum Constant{

    static var number = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
    
    enum saveKeyWord: String {
        case username
        case profileImage
        case image
    }
    
    enum profileImages: String, CaseIterable {
        case profile_0
        case profile_1
        case profile_2
        case profile_3
        case profile_4
        case profile_5
        case profile_6
        case profile_7
        case profile_8
        case profile_9
        case profile_10
        case profile_11
    }


    enum warningMessage: String {
        case basic = "닉네임에 @는 포함될 수 없어요."
        case pass = "사용할 수 있는 닉네임이에요."
        case countFail = "2글자 이상 10글자 미만으로 설정해주세요"
        case specialCharactersFail = "닉네임에 @, #, $, % 는 포함할 수 없어요."
        case blankFail = "공백은 불가능해요."
        case numberFail = "닉네임에 숫자는 포함할 수 없어요"
    }
    enum SpecialCharacters: String {
        case hashSymbol = "#"
        case percentSymbol = "%"
        case atTheRateSignSymbol = "@"
        case dollarSymbol = "$"
        case blankSymbol = " "
    }
}
