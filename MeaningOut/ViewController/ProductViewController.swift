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
        
        print(ResultViewController.like)
        
        if ResultViewController.like {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "like_selected"), style: .plain, target: self, action: nil)
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "like_unselected"), style: .plain, target: self, action: nil)
        }
       
        navigationItem.rightBarButtonItem?.tintColor = .black

        
        let url = URL(string: Variable.searchItem)!
        let request = URLRequest(url: url)
        webView.load(request)
        configureLayout()
    }
    
    func configureLayout() {
        view.addSubview(webView)
        
        webView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }


}
