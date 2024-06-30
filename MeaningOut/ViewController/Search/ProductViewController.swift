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
        var temporaryBasket: [String] = []
        Variable.like.toggle()
        if Variable.like {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: LikeImage.select.rawValue), style: .plain, target: self, action: nil)
            temporaryBasket = UserDefaultManager.myBasket
            for i in 0..<UserDefaultManager.myBasket.count {
                if UserDefaultManager.myBasket[i] == Self.productNumber {
                    temporaryBasket.append(UserDefaultManager.myBasket[i])
                }
            }
            UserDefaultManager.myBasket = temporaryBasket 
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: LikeImage.unselect.rawValue), style: .plain, target: self, action: nil)
            if UserDefaultManager.myBasket.count != 0 {
                for i in 0..<UserDefaultManager.myBasket.count {
                    if UserDefaultManager.myBasket[i] == Self.productNumber {
                        UserDefaultManager.myBasket.remove(at: i)
                        break
                    }
                }
                
            }
        }
        UserDefaults.standard.setValue(Variable.like, forKey: Self.productNumber)
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
