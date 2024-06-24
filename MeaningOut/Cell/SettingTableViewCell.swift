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
        button.isEnabled = false
        return button
    }()
    var basketButton = {
        let button = UIButton()
        button.setImage(UIImage(named: LikeImage.select.rawValue), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        button.isHidden = true
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
        contentView.addSubview(settingButton)
        contentView.addSubview(basketButton)
    }
    func configureLayout() {
        settingButton.snp.makeConstraints { make in
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(20)
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
        }
        basketButton.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.snp.trailing).inset(25)
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    func configureCell(data: IndexPath) {
        
        settingButton.setTitle(SettingMenu.allCases[data.row].rawValue, for: .normal)
        if SettingMenu.allCases[data.row].rawValue == "나의 장바구니 목록" {
            basketButton.isHidden = false
            configureBasket()
            
        } else {
            basketButton.isHidden = true
        }
    }
    func configureBasket() {
        let title = "\(String(describing: UserDefaultManager.myBasket.count))개의 상품"
        let highlighted = "\(UserDefaultManager.myBasket.count)개"
        let attributedTitle = NSMutableAttributedString(string: title)
        
        if let range = title.range(of: highlighted) {
            let nsRange = NSRange(range, in: title)
            attributedTitle.addAttribute(.foregroundColor, value: UIColor.black, range: nsRange)
            attributedTitle.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 15), range: nsRange)
        }
        basketButton.setAttributedTitle(attributedTitle, for: .normal)
    }
    
}
