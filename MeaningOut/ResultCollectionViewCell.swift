//
//  ResultCollectionViewCell.swift
//  MeaningOut
//
//  Created by 최대성 on 6/15/24.
//

import UIKit

class ResultCollectionViewCell: UICollectionViewCell {
 
    let categoryLabel = {
        let label = UILabel()
        label.layer.borderWidth = 0.5
        label.layer.borderColor = UIColor.lightGray.cgColor
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        
        contentView.addSubview(categoryLabel)
        
//        categoryLabel.snp.makeConstraints { make in
//            make.leading.
//        }
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
