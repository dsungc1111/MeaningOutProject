//
//  bigSizeButton.swift
//  MeaningOut
//
//  Created by 최대성 on 6/13/24.
//

import UIKit

class BigSizeButton: UIButton {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureBigButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureBigButton() {
        backgroundColor = UIColor.mainColor
        setTitleColor(.white, for: .normal)
        titleLabel?.textAlignment = .center
        layer.cornerRadius = 20
        titleLabel?.font = UIFont(name: "Marker Felt Wide", size: 16)
    }
    
}
