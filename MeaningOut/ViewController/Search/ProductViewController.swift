//
//  ProductDetailViewController.swift
//  MeaningOut
//
//  Created by 최대성 on 6/16/24.
//

import UIKit
import WebKit

class ProductViewController: UIViewController {

    static var productNumber = ""
    static var searchItemLink = ""
    var userLike = false
    
    let webView = WKWebView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let id = Self.productNumber
        userLike = UserDefaults.standard.bool(forKey: id)
        imageSet()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem?.tintColor = .black
        callRequest()
        configureLayout()
    }
    @objc func likeButtonTapped() {
        let id = Self.productNumber
        userLike.toggle()
        imageSet()
        UserDefaultManager.appendInMyBasket(productId: id, like: userLike)
        UserDefaults.standard.setValue(userLike, forKey: id)
    }
    func imageSet() {
        let image = userLike ? LikeImage.select.rawValue : LikeImage.unselect.rawValue
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: image), style: .plain, target: self, action: #selector(likeButtonTapped))
    }
    func callRequest() {
        if let url = URL(string: ProductViewController.searchItemLink) {
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
