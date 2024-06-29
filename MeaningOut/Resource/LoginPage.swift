//
//  LoginPage.swift
//  MeaningOut
//
//  Created by 최대성 on 6/18/24.
//

import Foundation

enum LoginError: Error {
    case short
    case long
    case specialCharacters
    case blank
    case number
}

enum WarningMessage: String {
    case basic = "닉네임에 @는 포함될 수 없어요."
    case pass = "사용할 수 있는 닉네임이에요."
    case countFail = "2글자 이상 10글자 미만으로 설정해주세요"
    case specialCharactersFail = "닉네임에 @, #, $, % 는 포함할 수 없어요."
    case blankFail = "공백은 불가능해요."
    case numberFail = "닉네임에 숫자는 포함할 수 없어요"
    case exception = "예상치 못한 오류"
}
enum SpecialCharacters: String, CaseIterable {
    case hashSymbol = "#"
    case percentSymbol = "%"
    case atTheRateSignSymbol = "@"
    case dollarSymbol = "$"
    case blankSymbol = " "
}
