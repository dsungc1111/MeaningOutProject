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
       
    lazy var likeButton = {
        let button = UIButton()
        button.contentMode = .scaleAspectFill
        button.layer.cornerRadius = 10
//        button.isUserInteractionEnabled = false
        button.addTarget(self, action: #selector(likeButtonTapped(sender:)), for: .touchUpInside)
        
        
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func likeButtonTapped(sender: UIButton) {
        var like = UserDefaults.standard.bool(forKey: "\(Variable.mySearch[sender.tag].title)")
        like.toggle()
        if like {
            likeButton.setImage(UIImage(named: "like_selected"), for: .normal)
            likeButton.backgroundColor = UIColor(hexCode: "FFFFFF", alpha: 0.5)
            Variable.temporaryBasket = Variable.myBasket
            Variable.temporaryBasket.append(Variable.mySearch[sender.tag].title)
            Variable.myBasket = Variable.temporaryBasket
        } else {
            likeButton.setImage(UIImage(named: "like_unselected"), for: .normal)
            likeButton.backgroundColor = UIColor(hexCode: "828282", alpha: 0.5)
            if Variable.myBasket.count != 0 {
                for i in 0..<Variable.myBasket.count {
                    if Variable.myBasket[i] == Variable.mySearch[sender.tag].title {
                        Variable.myBasket.remove(at: i)
                    }
                }
                
            }
        }
        UserDefaults.standard.setValue(like, forKey: "\(Variable.mySearch[sender.tag].title)")
    }
    
    
    func configureHierarchy() {
        contentView.addSubview(imageView)
        contentView.addSubview(companyNameLabel)
        contentView.addSubview(productNameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(likeButton)
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
        likeButton.snp.makeConstraints { make in
            make.bottom.equalTo(imageView.snp.bottom).inset(10)
            make.trailing.equalTo(imageView.snp.trailing).inset(10)
            make.size.equalTo(40)
        }
        
        
    }
    
    
    
    func configureCell(data: IndexPath) {
        let like = UserDefaults.standard.bool(forKey: "\(Variable.mySearch[data.item].title)")
       
        let url = URL(string: Variable.mySearch[data.row].image)
        imageView.kf.setImage(with: url)
        likeButton.tag = data.row
        companyNameLabel.text = Variable.mySearch[data.row].mallName
        productNameLabel.text = Variable.mySearch[data.row].title
        priceLabel.text = "\(Int(Variable.mySearch[data.row].lprice)?.formatted() ?? "0")원"
        
        if like {
            likeButton.setImage(UIImage(named: "like_selected"), for: .normal)
            likeButton.backgroundColor = UIColor(hexCode: "FFFFFF", alpha: 0.5)
        } else {
            likeButton.setImage(UIImage(named: "like_unselected"), for: .normal)
            likeButton.backgroundColor = UIColor(hexCode: "828282", alpha: 0.5)
        }
    }
    
}
