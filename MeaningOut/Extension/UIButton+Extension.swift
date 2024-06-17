//
//  UIButton+Extension.swift
//  MeaningOut
//
//  Created by 최대성 on 6/17/24.
//

import UIKit

extension UIButton.Configuration {
    
    static func settingButtons() -> UIButton.Configuration {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "로그인"
        configuration.subtitle = "Df"
        configuration.titleAlignment = .trailing
        configuration.baseBackgroundColor = .systemBlue
        configuration.baseForegroundColor = .darkGray
        configuration.image = UIImage(systemName: "star")
        configuration.imagePlacement = .leading
        configuration.imagePadding = 100
        configuration.cornerStyle = .capsule
        
        return configuration
    }
    
}
