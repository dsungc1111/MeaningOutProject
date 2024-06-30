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
    private init() {}
    
    func callRequest(sort: String, page: Int, completionHandler: @escaping (Shopping?, SearchError?) -> Void) {
        let scheme = "https"
        let host = "openapi.naver.com"
        let path = "/v1/search/shop.json"
        
        var component = URLComponents()
        component.scheme = scheme
        component.host = host
        component.path = path
        component.queryItems = [
            URLQueryItem(name: "query", value: UserDefaultManager.searchText),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "sort", value: sort)
        ]
        
        var request = URLRequest(url: component.url!, timeoutInterval: 2)
        
        request.addValue(APIKey().clientId, forHTTPHeaderField: "X-Naver-Client-Id")
        request.addValue(APIKey().secretKey, forHTTPHeaderField: "X-Naver-Client-Secret")
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.global().async {
                guard error == nil else {
                    print("Fail Request")
                    completionHandler(nil, .failedRequest)
                    return
                }
                guard let data = data else {
                    print("no data retruned")
                    completionHandler(nil, .noData)
                    return
                }
                guard let response = response as? HTTPURLResponse else {
                    print("unable response")
                    completionHandler(nil, .invalidResponse)
                    return
                }
                guard response.statusCode == 200 else {
                    print(response.statusCode)
                    print("failed resopnse")
                    completionHandler(nil, .failedRequest)
                    return
                }
                do {
                    let result = try JSONDecoder().decode(Shopping.self, from: data)
                    completionHandler(result, nil)
                } catch {
                    print("Error")
                    print(error)
                    completionHandler(nil, .invalidData)
                }
            }
        }.resume()
    }
}
