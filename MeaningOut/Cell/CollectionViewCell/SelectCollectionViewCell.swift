//
//  ProfileCollectionViewCell.swift
//  MeaningOut
//
//  Created by 최대성 on 6/14/24.
//

import UIKit

class SelectCollectionViewCell: UICollectionViewCell {
    
    
    lazy var profileImageButton = {
        let button = UIButton()
        button.alpha = 0.5
        button.backgroundColor = .white
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        contentView.addSubview(profileImageButton)
        profileImageButton.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
        profileImageButton.layer.cornerRadius = frame.width/2
        configureLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(data: IndexPath) {
        profileImageButton.setImage(UIImage(named: ProfileImages.allCases[data.row].rawValue), for: .normal)
        if UserDefaultManager.profileImage == ProfileImages.allCases[data.row].rawValue {
            layer.borderColor = UIColor.mainColor.cgColor
            profileImageButton.alpha = 1
        } else {
            layer.borderColor = UIColor.black.cgColor
            profileImageButton.alpha = 0.5
        }
    }
    
    func configureLayout() {
        clipsToBounds = true
        layer.cornerRadius = frame.width/2
        layer.borderWidth = 1
    }
}
