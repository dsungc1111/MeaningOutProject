//
//  SearchResultTableViewCell.swift
//  MeaningOut
//
//  Created by 최대성 on 6/14/24.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

    let timelogo = {
        let logo = UIImageView()
        logo.image = UIImage(systemName: "clock")
        logo.tintColor = .black
        return logo
    }()
    let resultLable = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    lazy var removeButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .darkGray
//        button.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    
//    @objc func removeButtonTapped(sender: UIBU) {
//        
//    }
//    
    
    func configureHierarchy() {
        contentView.addSubview(timelogo)
        contentView.addSubview(resultLable)
        contentView.addSubview(removeButton)

    }
    func configureLayout() {
        timelogo.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.leading.equalTo(contentView.snp.leading).inset(10)
            make.size.equalTo(18)
        }
        resultLable.snp.makeConstraints { make in
            make.leading.equalTo(timelogo.snp.trailing).offset(10)
            make.width.equalTo(300)
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
        }
        removeButton.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.size.equalTo(18)
        }
        
    }
   
    
}
