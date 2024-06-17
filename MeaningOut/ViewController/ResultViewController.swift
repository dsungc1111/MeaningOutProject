//
//  ResultViewController.swift
//  MeaningOut
//
//  Created by 최대성 on 6/14/24.
//

import UIKit
import Alamofire
import Kingfisher


struct Shopping: Decodable {
    let total: Int
    let start: Int
    let display: Int
    let items: [ProductInfo]
}

struct ProductInfo: Decodable{
    var title: String
    let link: String
    let mallName: String
    let image: String
    let lprice: String
}


class ResultViewController: UIViewController {
    
    static var like = false
    var page = 1
    let numberOfSearch = {
        let label = UILabel()
        label.text = "0개의 검색결과"
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = UIColor.mainColor
        return label
    }()
    lazy var accuracyButton = {
        let button = UIButton()
        button.tag = 0
        button.setTitle(Category.accuracy.rawValue, for: .normal)
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(filterButtonTapped(sender:)), for: .touchUpInside)
        return button
    }()
    lazy var dateButton = {
        let button = UIButton()
        button.tag = 1
        button.setTitle(Category.byDate.rawValue, for: .normal)
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(filterButtonTapped(sender:)), for: .touchUpInside)
        return button
    }()
    lazy var highPriceButton = {
        let button = UIButton()
        button.tag = 2
        button.setTitle(Category.highPrice.rawValue, for: .normal)
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(filterButtonTapped(sender:)), for: .touchUpInside)
        return button
    }()
    lazy var lowPriceButton = {
        let button = UIButton()
        button.tag = 3
        button.setTitle(Category.lowPrice.rawValue, for: .normal)
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(filterButtonTapped(sender:)), for: .touchUpInside)
        return button
    }()
    lazy var buttonList: [UIButton] = [accuracyButton, dateButton, highPriceButton, lowPriceButton]
    
    @objc func filterButtonTapped(sender: UIButton) {
        
        for i in 0..<buttonList.count {
            buttonList[i].backgroundColor = .white
            buttonList[i].setTitleColor(.black, for: .normal)
        }
        switch sender.tag {
        case 0:
            buttonList[sender.tag].backgroundColor = .darkGray
            buttonList[sender.tag].setTitleColor(.white, for: .normal)
            callRequest(sort: "sim")
        case 1:
            buttonList[sender.tag].backgroundColor = .darkGray
            buttonList[sender.tag].setTitleColor(.white, for: .normal)
            callRequest(sort: "date")
        case 2:
            buttonList[sender.tag].backgroundColor = .darkGray
            buttonList[sender.tag].setTitleColor(.white, for: .normal)
            callRequest(sort: "dsc")
        case 3:
            buttonList[sender.tag].backgroundColor = .darkGray
            buttonList[sender.tag].setTitleColor(.white, for: .normal)
            callRequest(sort: "asc")
        default:
            break
        }
    }
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    static func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let sectionSpacing: CGFloat = 10
        let cellSpacing: CGFloat = 10
        let width = UIScreen.main.bounds.width - (sectionSpacing*2 + cellSpacing*2)
        layout.itemSize = CGSize(width: width/2, height: width - sectionSpacing - cellSpacing)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = cellSpacing
        layout.minimumLineSpacing = cellSpacing
        layout.sectionInset = UIEdgeInsets(top: sectionSpacing, left: sectionSpacing, bottom: sectionSpacing, right: sectionSpacing)
        return layout
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureCollecionView()
        callRequest(sort: "sim")
        buttonList[0].backgroundColor = .darkGray
        buttonList[0].setTitleColor(.white, for: .normal)
        configurehierarchy()
        configureLayout()
    }
    override func viewDidLayoutSubviews() {
        navigationController?.navigationBar.layer.addBorder([.bottom], color: .systemGray4, width: 1)
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    func configureCollecionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.prefetchDataSource = self
        collectionView.register(ResultCollectionViewCell.self, forCellWithReuseIdentifier: ResultCollectionViewCell.identifier)
    }
    func configurehierarchy() {
        view.addSubview(numberOfSearch)
        view.addSubview(accuracyButton)
        view.addSubview(dateButton)
        view.addSubview(highPriceButton)
        view.addSubview(lowPriceButton)
        view.addSubview(collectionView)
    }
    func configureLayout() {
        numberOfSearch.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        accuracyButton.snp.makeConstraints { make in
            make.top.equalTo(numberOfSearch.snp.bottom).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.width.equalTo(70)
        }
        dateButton.snp.makeConstraints { make in
            make.top.equalTo(numberOfSearch.snp.bottom).offset(10)
            make.leading.equalTo(accuracyButton.snp.trailing).offset(10)
            make.width.equalTo(70)
        }
        highPriceButton.snp.makeConstraints { make in
            make.top.equalTo(numberOfSearch.snp.bottom).offset(10)
            make.leading.equalTo(dateButton.snp.trailing).offset(10)
            make.width.equalTo(100)
        }
        lowPriceButton.snp.makeConstraints { make in
            make.top.equalTo(numberOfSearch.snp.bottom).offset(10)
            make.leading.equalTo(highPriceButton.snp.trailing).offset(10)
            make.width.equalTo(100)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(lowPriceButton.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    func callRequest(sort: String) {
        let url = "https://openapi.naver.com/v1/search/shop.json?query=\(Variable.searchText)&page=\(page)&display=30&sort=\(sort)"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id" : APIKey().clientId, "X-Naver-Client-Secret" : APIKey().secretKey]
        
        AF.request(url, method: .get, headers: header).responseDecodable(of: Shopping.self) { response in
            switch response.result {
            case .success(let value):
                var products: [ProductInfo] = []
                for var i in value.items {
                    i.title = i.title.removeHtmlTag
                    products.append(i)
                    if self.page == 1{
                        Variable.mySearch = products
                    } else {
                        Variable.mySearch.append(contentsOf: products)
                    }
                }
                self.numberOfSearch.text = "\(value.total.formatted())개의 검색결과"
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
extension ResultViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Variable.mySearch.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultCollectionViewCell.identifier, for: indexPath) as? ResultCollectionViewCell else { return ResultCollectionViewCell() }
        
        ResultViewController.like = UserDefaults.standard.bool(forKey: "\(Variable.mySearch[indexPath.item].title)")
        cell.configureCell(data: indexPath)
        if ResultViewController.like {
            cell.likeButton.setImage(UIImage(named: Constant.likeImage.select.rawValue), for: .normal)
            cell.likeButton.backgroundColor = UIColor(hexCode: "FFFFFF", alpha: 0.5)
        } else {
            cell.likeButton.setImage(UIImage(named: Constant.likeImage.unselect.rawValue), for: .normal)
            cell.likeButton.backgroundColor = UIColor(hexCode: "828282", alpha: 0.5)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ProductViewController()
        vc.navigationItem.title = Variable.mySearch[indexPath.item].title
        Variable.searchItem = Variable.mySearch[indexPath.item].link
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension ResultViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for item in indexPaths {
            if Variable.mySearch.count - 8 == item.row {
                page += 1
                callRequest(sort: "sim")
                buttonList[0].backgroundColor = .darkGray
                buttonList[0].setTitleColor(.white, for: .normal)
            }
        }
    }
}
