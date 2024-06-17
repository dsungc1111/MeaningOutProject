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
        print(title)
        for i in 0..<Variable.myBasket.count {
            if title == Variable.myBasket[i] {
                count += 1
            }
        }
        print(count)
        if count == 0 {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "like_unselected"), style: .plain, target: self, action: #selector(likeButtonTapped))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "like_selected"), style: .plain, target: self, action: #selector(likeButtonTapped))
        }
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        
        
        navigationItem.rightBarButtonItem?.tintColor = .black
        
        
        let url = URL(string: Variable.searchItem)!
        let request = URLRequest(url: url)
        webView.load(request)
        configureLayout()
    }
    
    
    @objc func likeButtonTapped() {
        ResultViewController.like = UserDefaults.standard.bool(forKey: "\(navigationItem.title!)")
        Variable.temporaryBasket = []
        ResultViewController.like.toggle()
        if ResultViewController.like {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "like_selected"), style: .plain, target: self, action: nil)
            Variable.temporaryBasket = Variable.myBasket
            Variable.temporaryBasket.append(navigationItem.title!)
            Variable.myBasket = Variable.temporaryBasket
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "like_unselected"), style: .plain, target: self, action: nil)
            if Variable.myBasket.count != 0 {
                for i in 0..<Variable.myBasket.count {
                    if Variable.myBasket[i] == navigationItem.title! {
                        Variable.myBasket.remove(at: i)
                        break
                    }
                }
                
            }
        }
        UserDefaults.standard.setValue(ResultViewController.like, forKey: "\(navigationItem.title!)")
    }
    
    
    
    func configureLayout() {
        view.addSubview(webView)
        
        webView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }



}
