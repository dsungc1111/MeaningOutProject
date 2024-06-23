//
//  ProductDetailViewController.swift
//  MeaningOut
//
//  Created by 최대성 on 6/16/24.
//

import UIKit
import WebKit

class ProductViewController: UIViewController {

    let webView = WKWebView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        guard let title = navigationItem.title else { return }
        var count = 0
        for i in 0..<UserDefaultManager.myBasket.count {
            if title == UserDefaultManager.myBasket[i] {
                count += 1
            }
        }
        if count == 0 {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: LikeImage.unselect.rawValue), style: .plain, target: self, action: #selector(likeButtonTapped))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: LikeImage.select.rawValue), style: .plain, target: self, action: #selector(likeButtonTapped))
        }
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem?.tintColor = .black
        callRequest()
        configureLayout()
    }
    
    @objc func likeButtonTapped() {
        Variable.like = UserDefaults.standard.bool(forKey: "\(navigationItem.title!)")
        var temporaryBasket: [String] = []
        Variable.like.toggle()
        if Variable.like {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: LikeImage.select.rawValue), style: .plain, target: self, action: nil)
            temporaryBasket = UserDefaultManager.myBasket
            temporaryBasket.append(navigationItem.title!)
            UserDefaultManager.myBasket = temporaryBasket
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: LikeImage.unselect.rawValue), style: .plain, target: self, action: nil)
            if UserDefaultManager.myBasket.count != 0 {
                for i in 0..<UserDefaultManager.myBasket.count {
                    if UserDefaultManager.myBasket[i] == navigationItem.title! {
                        UserDefaultManager.myBasket.remove(at: i)
                        break
                    }
                }
                
            }
        }
        UserDefaults.standard.setValue(Variable.like, forKey: "\(navigationItem.title!)")
    }
    
    func callRequest() {
        if let url = URL(string: Variable.searchItem) {
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
