//
//  ResultCollectionViewCell.swift
//  MeaningOut
//
//  Created by 최대성 on 6/15/24.
//

import UIKit

class ResultCollectionViewCell: UICollectionViewCell {
    
    
    let imageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.contentMode = .scaleToFill
        return image
    }()
    let companyNameLabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    let productNameLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.numberOfLines = 2
        return label
    }()
    let priceLabel = {
       let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        contentView.addSubview(imageView)
        contentView.addSubview(companyNameLabel)
        contentView.addSubview(productNameLabel)
        contentView.addSubview(priceLabel)
    }
    
    func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(100)
        }
        companyNameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(5)
            make.height.equalTo(20)
        }
        productNameLabel.snp.makeConstraints { make in
            make.top.equalTo(companyNameLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(5)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(productNameLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(5)
        }
        
        
    }
    
    
}
