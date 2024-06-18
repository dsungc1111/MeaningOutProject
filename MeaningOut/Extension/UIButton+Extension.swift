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
        configuration.baseBackgroundColor = .white
        configuration.baseForegroundColor = .black
        configuration.image = UIImage(systemName: "clock")
        configuration.imagePlacement = .leading
        configuration.imagePadding = 10
        return configuration
    }
    
}
