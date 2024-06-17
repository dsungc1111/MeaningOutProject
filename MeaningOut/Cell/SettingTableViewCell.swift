//
//  ProductDetailTableViewCell.swift
//  MeaningOut
//
//  Created by 최대성 on 6/17/24.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    var settingButton = {
        let button = UIButton()
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    var basketLabel = {
        let label = UILabel()
        label.text = "장바구니 개수"
        label.font = .systemFont(ofSize: 14)
        label.isHidden = true
        return label
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
        contentView.addSubview(settingButton)
        contentView.addSubview(basketLabel)
    }
    func configureLayout() {
        settingButton.snp.makeConstraints { make in
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(25)
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
        }
        basketLabel.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.snp.trailing).inset(25)
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    func configureCell(data: IndexPath) {
        
        settingButton.setTitle(SettingMenu.allCases[data.row].rawValue, for: .normal)
        
        if data.row == 0 {
            basketLabel.isHidden = false
            basketLabel.text = "\(Variable.myBasket.count)개의 장바구니"
        } else {
            basketLabel.text = ""
        }
    }
    
}
