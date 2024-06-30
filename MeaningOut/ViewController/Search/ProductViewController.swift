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
    
    let webView = WKWebView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let id = Self.productNumber
        Variable.like = UserDefaults.standard.bool(forKey: id)
        imageSet()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem?.tintColor = .black
        callRequest()
        configureLayout()
    }
    
    @objc func likeButtonTapped() {
        let id = Self.productNumber
        Variable.like.toggle()
        imageSet()
        UserDefaultManager.appendInMyBasket(productId: id, like: Variable.like)
        UserDefaults.standard.setValue(Variable.like, forKey: id)
    }
    
    func imageSet() {
        let image = Variable.like ? LikeImage.select.rawValue : LikeImage.unselect.rawValue
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
