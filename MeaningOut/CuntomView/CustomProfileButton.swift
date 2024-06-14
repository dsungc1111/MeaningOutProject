//
//  CustomImages.swift
//  MeaningOut
//
//  Created by 최대성 on 6/13/24.
//

import UIKit

class CustomProfileButton: UIButton {
    
//    var imageString = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureImage() {
        
//        imageString = Constant.profileImages.allCases.randomElement()!.rawValue
//        setImage(UIImage(named: imageString), for: .normal)
//        
        if Variable.profileImage == "" {
            Variable.profileImage = Constant.profileImages.allCases.randomElement()!.rawValue
            setImage(UIImage(named: Variable.profileImage), for: .normal)
        }
        
        clipsToBounds = true
        contentMode = .scaleAspectFit
        layer.borderWidth = 3
        layer.borderColor = UIColor.mainColor.cgColor
        
        
    }
}
