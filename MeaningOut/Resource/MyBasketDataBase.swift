//
//  MyBasketDataBase.swift
//  MeaningOut
//
//  Created by 최대성 on 7/7/24.
//

import UIKit
import RealmSwift

class RealmTable: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted(indexed: true) var productName: String
    @Persisted var link: String?
    @Persisted var productId: String?
    @Persisted var mallName: String?
    @Persisted var image: String?
    @Persisted var lprice: String?
    @Persisted var isLike: Bool
    
    convenience init(productName: String, link: String?, productId: String?, mallName: String?, image: String?, lprice: String?, isLike: Bool ) {
        self.init()
        self.productName = productName
        self.link = link
        self.mallName = mallName
        self.productId = productId
        self.image = image
        self.lprice = lprice
        self.isLike = isLike
    }
    
}
