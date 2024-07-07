//
//  MyBasketCollectionViewCell.swift
//  MeaningOut
//
//  Created by 최대성 on 7/7/24.
//

import UIKit
import RealmSwift
import SnapKit

class BasketCollectionViewCell: UICollectionViewCell {
    
    let realm = try! Realm()
    var page = 1
    private var userLike = false
//    lazy var list = realm.objects(RealmTable.self).filter("isLike == %@", true)
    
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
//        button.addTarget(self, action: #selector(likeButtonTapped(sender:)), for: .touchUpInside)
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
//    @objc func likeButtonTapped(sender: UIButton) {
//        let items = list[sender.tag]
//        userLike = UserDefaults.standard.bool(forKey: items.productId ?? "")
//        userLike.toggle()
//        imageSet()
//        if userLike {
//            try! self.realm.write {
//                self.realm.create(RealmTable.self, value: ["productName": items.productName.removeHtmlTag, "link": items.link ?? "","productId" : items.productId ?? "" ,"mallName": items.mallName ?? "", "image": items.image ?? "", "lprice": items.lprice ?? "", "isLike": userLike], update: .modified)
//            }
//        } else {
//            if let removeItem = realm.objects(RealmTable.self).filter("productId == %@", items.productId ?? "").first {
//                      try! self.realm.write {
//                          self.realm.delete(removeItem)
//                      }
//                  }
//        }
//        UserDefaultManager.appendInMyBasket(productId: items.productId ?? "", like: userLike)
//        UserDefaults.standard.setValue(userLike, forKey: items.productId ?? "")
//    }
//    
    
    func imageSet() {
        let likeImage = userLike ? LikeImage.select.rawValue : LikeImage.unselect.rawValue
        likeButton.setImage(UIImage(named: likeImage), for: .normal)
        likeButton.backgroundColor  = userLike ? UIColor(hexCode: "FFFFFF", alpha: 0.5) : UIColor(hexCode: "828282", alpha: 0.5)
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
        let list = BasketViewController.list
        likeButton.tag = data.row
        let url = URL(string: list?[data.row].image ?? "")!
        imageView.kf.setImage(with: url)
        companyNameLabel.text = list?[data.row].mallName
        productNameLabel.text = list?[data.row].productName.removeHtmlTag
        priceLabel.text = "\(Int(list?[data.row].lprice ?? "0")?.formatted() ?? "0")원"
        userLike = UserDefaults.standard.bool(forKey: "\(list?[data.row].productId ?? "")")
        imageSet()
    }
    
}
