//
//  IdentiFier.swift
//  MeaningOut
//
//  Created by 최대성 on 6/14/24.
//

import UIKit


protocol IdentiFier{
    static var identifier: String { get }
}

extension UICollectionViewCell: IdentiFier {
    static var identifier: String {
        return String(describing: self)
    }
}
