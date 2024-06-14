//
//  CameraLogo.swift
//  MeaningOut
//
//  Created by 최대성 on 6/14/24.
//

import UIKit

class CameraLogo: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCameraLogo()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCameraLogo() {
        image = UIImage(systemName: "camera.fill")
        backgroundColor = UIColor.mainColor
        tintColor = .white
        contentMode = .center
    }
}
