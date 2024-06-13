//
//  CustomImages.swift
//  MeaningOut
//
//  Created by 최대성 on 6/13/24.
//

import UIKit

class CustomImages: UIButton {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureImage() {
        clipsToBounds = true
        contentMode = .scaleAspectFit
        layer.frame.size.width = 100
        layer.frame.size.height = 100
        layer.cornerRadius = frame.width/2
        layer.borderWidth = 3
        layer.borderColor = UIColor.mainColor.cgColor
    }
}
