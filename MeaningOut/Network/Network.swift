//
//  Network.swift
//  MeaningOut
//
//  Created by 최대성 on 6/21/24.
//


import UIKit
import Alamofire



class Network {
    
    static var shared = Network()
    static var contentCount = 0
    private init() {}
    
    
    func callRequest(sort: String, page: Int, completionHanler: @escaping ([ProductInfo]) -> Void) {
        let url = "https://openapi.naver.com/v1/search/shop.json?"
        let param: Parameters = [
            "query" : UserDefaultManager.searchText,
            "page" : "\(page)",
            "sort" : sort
        ]
        let header: HTTPHeaders = [
            "X-Naver-Client-Id" : APIKey().clientId, "X-Naver-Client-Secret" : APIKey().secretKey]
        
        AF.request(url, method: .get, parameters: param, headers: header).responseDecodable(of: Shopping.self) { response in
            switch response.result {
            case .success(let value):
                Network.contentCount = value.total
                if value.items.count == 0 {
                    Variable.mySearch = []
                } else {
                    var products: [ProductInfo] = []
                    for var i in value.items {
                        i.title = i.title.removeHtmlTag
                        products.append(i)
                    }
                    completionHanler(products)
                }
            case .failure(let error):
//                self.numberOfSearch.text = AlertMention.network.rawValue
                let alert = UIAlertController(title: AlertMention.connectionError.rawValue, message: AlertMention.network.rawValue, preferredStyle: .alert)
                let okButton = UIAlertAction(title: AlertMention.networkChecking.rawValue, style: .default)
                alert.addAction(okButton)
//                self.present(alert, animated: true)
                Variable.mySearch = []
                print(error)
            }
        }
            
    }
}
