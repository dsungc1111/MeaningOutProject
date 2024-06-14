//
//  ProfileCollectionViewCell.swift
//  MeaningOut
//
//  Created by 최대성 on 6/14/24.
//

import UIKit

class SelectCollectionViewCell: UICollectionViewCell {
    
    lazy var profileImageButton = {
        let image = UIButton()
        let select = false
        image.alpha = 0.5
        image.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        return image
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
    @objc func profileButtonTapped() {
        isSelected.toggle()
        let color = isSelected ? UIColor.mainColor : UIColor.black
        layer.borderColor = color.cgColor
//        profileImageButton.
        
        Variable.profileImage = Constant.profileImages.allCases[profileImageButton.tag].rawValue
        let vc = SelectViewController()
        vc.profileButton.setImage(UIImage(named: Variable.profileImage), for: .normal)
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureCell(data: IndexPath) {
        profileImageButton.setImage(UIImage(named: Constant.profileImages.allCases[data.row].rawValue), for: .normal)
        profileImageButton.tag = data.row
    }
    
    func configureLayout() {
        clipsToBounds = true
        layer.cornerRadius = frame.width/2
        layer.borderWidth = 1
    }
}
