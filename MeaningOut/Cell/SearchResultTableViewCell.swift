//
//  SearchResultTableViewCell.swift
//  MeaningOut
//
//  Created by 최대성 on 6/14/24.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

    
    let timelogoButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "clock"), for: .normal)
        button.tintColor = .black
        button.configuration?.titlePadding = 10
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        return button
    }()
    lazy var resultButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.contentHorizontalAlignment = .left
        button.setTitleColor(.black, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        return button
    }()
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
        configureHierarchy()
        configureLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureHierarchy() {
        contentView.addSubview(removeButton)
        contentView.addSubview(timelogoButton)
        contentView.addSubview(resultButton)
    }
    func configureLayout() {
        timelogoButton.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.leading.equalTo(contentView.safeAreaLayoutGuide)
            make.verticalEdges.equalTo(contentView.safeAreaLayoutGuide)
            make.width.equalTo(30)
        }
        removeButton.snp.makeConstraints { make in
             make.centerY.equalTo(contentView.safeAreaLayoutGuide)
             make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(10)
             make.size.equalTo(18)
         }
        resultButton.snp.makeConstraints { make in
            make.leading.equalTo(timelogoButton.snp.trailing)
            make.trailing.equalTo(removeButton.snp.leading)
            make.verticalEdges.equalTo(contentView.safeAreaLayoutGuide)
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
}
