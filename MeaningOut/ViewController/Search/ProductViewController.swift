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

    var productNumber = ""
    var searchItemLink = ""
    private var userLike = false
    private let realm = try! Realm()
    
    private let webView = WKWebView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let id = productNumber
        userLike = UserDefaults.standard.bool(forKey: id)
        imageSet()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem?.tintColor = .black
        callRequest()
        configureLayout()
    }
    @objc func likeButtonTapped() {
        let id = productNumber
        let list = realm.objects(RealmTable.self).filter("productId == %@", id)
        userLike.toggle()
        imageSet()
        print(list)
        if userLike {
            try! self.realm.write {
                
                self.realm.create(RealmTable.self, value: ["productId": id, "isLike": userLike], update: .modified)
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
        if let url = URL(string: searchItemLink) {
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
