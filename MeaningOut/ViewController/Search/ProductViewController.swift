//
//  ProductDetailViewController.swift
//  MeaningOut
//
//  Created by 최대성 on 6/16/24.
//

import UIKit
import WebKit
import RealmSwift

final class ProductViewController: UIViewController {

    private var userLike = false
    private let realm = try! Realm()
    private var realmList = RealmTable(productName: "", link: "", productId: "", mallName: "", image: "", lprice: "", isLike: false)
    var basketList = ProductInfo(title: "", link: "", mallName: "", image: "", lprice: "", productId: "")
    
    
    private let webView = WKWebView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let id = basketList.productId
        userLike = UserDefaults.standard.bool(forKey: id)
        imageSet()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem?.tintColor = .black
        callRequest()
        configureLayout()
    }
    @objc func likeButtonTapped() {
        let id = basketList.productId
        let list = realm.objects(RealmTable.self).filter("productId == %@", id)
        userLike.toggle()
        imageSet()
        if userLike {
            if list.isEmpty {
                try! self.realm.write {
                    self.realm.create(RealmTable.self, value: ["productName": basketList.title.removeHtmlTag, "link": basketList.link,"productId" : basketList.productId ,"mallName": basketList.mallName, "image": basketList.image, "lprice": basketList.lprice, "isLike": userLike], update: .modified)
                }
            } else {
                if let removeItem = list.first {
                    try! self.realm.write {
                        self.realm.delete(removeItem)
                    }
                }
            }
        } else {
            if let removeItem = list.first {
                try! self.realm.write {
                    self.realm.delete(removeItem)
                }
            }
        }
        UserDefaultManager.appendInMyBasket(productId: id, like: userLike)
        UserDefaults.standard.setValue(userLike, forKey: id)
    }
    
    
    private func imageSet() {
        let image = userLike ? LikeImage.select.rawValue : LikeImage.unselect.rawValue
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: image), style: .plain, target: self, action: #selector(likeButtonTapped))
    }
    private func callRequest() {
        if let url = URL(string: basketList.link) {
            let request = URLRequest(url: url)
            webView.load(request)
        } else {
            let alert = UIAlertController(title: AlertMention.connectionError.rawValue, message: AlertMention.network.rawValue, preferredStyle: .alert)
            let okButton = UIAlertAction(title: AlertMention.networkChecking.rawValue, style: .default)
            alert.addAction(okButton)
            self.present(alert, animated: true)
        }
    }
    func configureLayout() {
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
