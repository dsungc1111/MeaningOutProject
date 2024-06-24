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
    
    func callRequest(sort: String, page: Int, completionHanler: @escaping (Result<[ProductInfo], Error>) -> Void) {
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
                    completionHanler(.success(products))
                }
            case .failure(let error):
                Variable.mySearch = []
                completionHanler(.failure(error))
            }
        }
    }
}
