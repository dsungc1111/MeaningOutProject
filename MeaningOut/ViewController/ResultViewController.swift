//
//  ResultViewController.swift
//  MeaningOut
//
//  Created by 최대성 on 6/14/24.
//

import UIKit
import Alamofire

struct Shopping: Decodable {
    let total: Int
    let start: Int
    let display: Int
    let items: [ProductInfo]
}

struct ProductInfo: Decodable{
    let title: String
    let link: String
    let mallName: String
    let image: String
    let lprice: String
}



class ResultViewController: UIViewController {

    var mySearch: [ProductInfo] = []
    
    let numberOfSearch = {
       let label = UILabel()
        label.text = "21개의 검색결과"
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = UIColor.mainColor
        return label
    }()
    
    let categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: CategoryCollectionViewLayout())
    
    static func CategoryCollectionViewLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewFlowLayout()
        let sectionSpacing: CGFloat = 30
        let cellSpacing: CGFloat = 10
        let width = UIScreen.main.bounds.width - (sectionSpacing*2 + cellSpacing*3)
        layout.itemSize = CGSize(width: width/4, height: width/4)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = cellSpacing
        layout.minimumLineSpacing = cellSpacing
        layout.sectionInset = UIEdgeInsets(top: sectionSpacing, left: sectionSpacing, bottom: sectionSpacing, right: sectionSpacing)
        return layout
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.register(ResultCollectionViewCell.self, forCellWithReuseIdentifier: ResultCollectionViewCell.identifier)
        callRequest()
        configurehierarchy()
        configureLayout()
    }
    override func viewDidLayoutSubviews() {
        navigationController?.navigationBar.layer.addBorder([.bottom], color: .systemGray4, width: 1)
    }
    
    func configurehierarchy() {
        view.addSubview(numberOfSearch)
        view.addSubview(categoryCollectionView)
    }
    func configureLayout() {
        numberOfSearch.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(numberOfSearch.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            
            make.height.equalTo(50)
        }
        categoryCollectionView.backgroundColor = .systemBlue
    }
    
    
    func callRequest() {
        
        let url = "https://openapi.naver.com/v1/search/shop.json?query=String&display=30"
        
        let header: HTTPHeaders = ["X-Naver-Client-Id" : "Hc5_csSXTiRg9TJ7xTXh", "X-Naver-Client-Secret" : "6ykniciEiv"]
        
        AF.request(url, method: .get, headers: header).responseDecodable(of: Shopping.self) { response in
            switch response.result {
            case .success(let value):
                self.mySearch = value.items
                print(self.mySearch)
                print(value)
            case .failure(let error):
                print(error)
            }
        }
        
    }
}


extension ResultViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: ResultCollectionViewCell.identifier, for: indexPath) as? ResultCollectionViewCell else { return ResultCollectionViewCell() }
        
        
        return cell
    }
    
    
}
