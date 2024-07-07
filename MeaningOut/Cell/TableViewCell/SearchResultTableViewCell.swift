//
//  SearchResultTableViewCell.swift
//  MeaningOut
//
//  Created by 최대성 on 6/14/24.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    
    
    let resultButton = UIButton()
    
    lazy var removeButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.backgroundColor = .clear
        button.tintColor = .darkGray
        button.isUserInteractionEnabled = false
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        resultButton.configuration = .settingButtons()
        resultButton.contentHorizontalAlignment = .left
        configureHierarchy()
        configureLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureHierarchy() {
        contentView.addSubview(removeButton)
        contentView.addSubview(resultButton)
    }
    func configureLayout() {
        removeButton.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.size.equalTo(18)
        }
        resultButton.snp.makeConstraints { make in
            make.leading.equalTo(contentView.safeAreaLayoutGuide)
            make.trailing.equalTo(removeButton.snp.leading)
            make.verticalEdges.equalTo(contentView.safeAreaLayoutGuide)
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    
    func configureCell(data: IndexPath) {
        resultButton.setTitle(UserDefaultManager.searchList[data.row], for: .normal)
    }
}
