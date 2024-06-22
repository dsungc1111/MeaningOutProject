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
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func likeButtonTapped(sender: UIButton) {
        Variable.like = UserDefaults.standard.bool(forKey: "\(Variable.mySearch[sender.tag].title)")
        temporaryBasket = []
        Variable.like.toggle()
        if Variable.like {
            likeButton.setImage(UIImage(named: LikeImage.select.rawValue), for: .normal)
            likeButton.backgroundColor = UIColor(hexCode: "FFFFFF", alpha: 0.5)
            temporaryBasket = UserDefaultManager.myBasket
            temporaryBasket.append(Variable.mySearch[sender.tag].title)
            UserDefaultManager.myBasket = temporaryBasket
        } else {
            likeButton.setImage(UIImage(named: LikeImage.unselect.rawValue), for: .normal)
            likeButton.backgroundColor = UIColor(hexCode: "828282", alpha: 0.5)
            if UserDefaultManager.myBasket.count != 0 {
                for i in 0..<UserDefaultManager.myBasket.count {
                    if UserDefaultManager.myBasket[i] == Variable.mySearch[sender.tag].title {
                        UserDefaultManager.myBasket.remove(at: i)
                        break
                    }
                }
                
            }
        }
        UserDefaults.standard.setValue(Variable.like, forKey: "\(Variable.mySearch[sender.tag].title)")
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
                let url = URL(string: Variable.mySearch[data.row].image)!
                let image = try Data(contentsOf: url)
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: image)
                }
              } catch {
                
                  self.imageView.image = UIImage(systemName: "star")
            }
        }
        likeButton.tag = data.row
        companyNameLabel.text = Variable.mySearch[data.row].mallName
        productNameLabel.text = Variable.mySearch[data.row].title
        priceLabel.text = "\(Int(Variable.mySearch[data.row].lprice)?.formatted() ?? "0")원"
        if Variable.like {
            likeButton.setImage(UIImage(named: LikeImage.select.rawValue), for: .normal)
            likeButton.backgroundColor = UIColor.customWhite.withAlphaComponent(1)
        } else {
            likeButton.setImage(UIImage(named: LikeImage.unselect.rawValue), for: .normal)
            likeButton.backgroundColor = UIColor.customDarkGray.withAlphaComponent(0.5)
        }
    }
    
}
