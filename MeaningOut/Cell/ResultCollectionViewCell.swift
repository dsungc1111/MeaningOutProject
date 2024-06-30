//
//  ResultCollectionViewCell.swift
//  MeaningOut
//
//  Created by 최대성 on 6/15/24.
//

import UIKit

class ResultCollectionViewCell: UICollectionViewCell {
    var temporaryBasket: [String] = []
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
        button.addTarget(self, action: #selector(likeButtonTapped(sender:)), for: .touchUpInside)
        return button
    }()
    var userLike = false
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func likeButtonTapped(sender: UIButton) {
        let id = ResultViewController.shoppingList.items[sender.tag].productId
        userLike = UserDefaults.standard.bool(forKey: id)
        userLike.toggle()
        imageSet()
        UserDefaultManager.appendInMyBasket(productId: id, like: userLike)
        UserDefaults.standard.setValue(userLike, forKey: id)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        companyNameLabel.text = nil
        productNameLabel.text = nil
        priceLabel.text = nil
        likeButton.setImage(nil, for: .normal)
        likeButton.backgroundColor = .clear
    }
    func imageSet() {
        let likeImage = userLike ? LikeImage.select.rawValue : LikeImage.unselect.rawValue
        let backgroundColor = userLike ? UIColor(hexCode: "FFFFFF", alpha: 0.5) : UIColor(hexCode: "828282", alpha: 0.5)
        likeButton.setImage(UIImage(named: likeImage), for: .normal)
        likeButton.backgroundColor = backgroundColor
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
        DispatchQueue.global().async {
            do {
                let url = URL(string: ResultViewController.shoppingList.items[data.row].image)!
                let image = try Data(contentsOf: url)
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: image)
                }
            } catch {
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(systemName: "star")
                }
            }
        }
        likeButton.tag = data.row
        companyNameLabel.text = ResultViewController.shoppingList.items[data.row].mallName
        productNameLabel.text = ResultViewController.shoppingList.items[data.row].title.removeHtmlTag
        priceLabel.text = "\(Int(ResultViewController.shoppingList.items[data.row].lprice)?.formatted() ?? "0")원"
        
        userLike = UserDefaults.standard.bool(forKey: "\(ResultViewController.shoppingList.items[data.row].productId)")
        imageSet()
    }
    
}
