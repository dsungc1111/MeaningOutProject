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
    var items: [ProductInfo]
}
struct ProductInfo: Codable {
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
enum CategoryEng: String {
    case sim
    case date
    case dsc
    case asc
}

enum AlertMention: String {
    case network = "네트워크를 확인해주세요."
    case connectionError = "연결 끊김"
    case networkChecking = "확인"
}


