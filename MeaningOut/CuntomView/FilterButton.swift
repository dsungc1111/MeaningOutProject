//
//  FilterButton.swift
//  MeaningOut
//
//  Created by 최대성 on 6/18/24.
//

import UIKit

class FilterButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureBigButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureBigButton() {
        layer.cornerRadius = 15
        layer.borderWidth = 1
        setTitleColor(.black, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 15)
    }
}

