//
//  Enum+Variable.swift
//  MeaningOut
//
//  Created by 최대성 on 6/13/24.
//

import Foundation

struct Shopping: Decodable {
    let total: Int
    let start: Int
    let display: Int
    let items: [ProductInfo]
}
struct ProductInfo: Decodable{
    var title: String
    let link: String
    let mallName: String
    let image: String
    let lprice: String
    let productId: String
}

enum Category: String {
    case accuracy = "정확도"
    case byDate = "날짜순"
    case highPrice = "높은가격순"
    case lowPrice = "낮은가격순"
}
