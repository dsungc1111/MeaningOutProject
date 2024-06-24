//
//  ResultViewController.swift
//  MeaningOut
//
//  Created by 최대성 on 6/14/24.
//

import UIKit
import Alamofire
import Kingfisher

class ResultViewController: UIViewController {
    var category = ""
    var page = 1
    let numberOfSearch = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = UIColor.mainColor
        return label
    }()
    lazy var accuracyButton = {
        let button = FilterButton()
        button.tag = 0
        button.setTitle(Category.accuracy.rawValue, for: .normal)
        button.addTarget(self, action: #selector(filterButtonTapped(sender:)), for: .touchUpInside)
        return button
    }()
    lazy var dateButton = {
        let button = FilterButton()
        button.tag = 1
        button.setTitle(Category.byDate.rawValue, for: .normal)
        button.addTarget(self, action: #selector(filterButtonTapped(sender:)), for: .touchUpInside)
        return button
    }()
    lazy var highPriceButton = {
        let button = FilterButton()
        button.tag = 2
        button.setTitle(Category.highPrice.rawValue, for: .normal)
        button.addTarget(self, action: #selector(filterButtonTapped(sender:)), for: .touchUpInside)
        return button
    }()
    lazy var lowPriceButton = {
        let button = FilterButton()
        button.tag = 3
        button.setTitle(Category.lowPrice.rawValue, for: .normal)
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
            page = 1
            getNetworkData(sort: CategoryEng.sim.rawValue)
            category = CategoryEng.sim.rawValue
        case 1:
            buttonList[sender.tag].backgroundColor = .darkGray
            buttonList[sender.tag].setTitleColor(.white, for: .normal)
            page = 1
            getNetworkData(sort: CategoryEng.date.rawValue)
            category = CategoryEng.date.rawValue
        case 2:
            buttonList[sender.tag].backgroundColor = .darkGray
            buttonList[sender.tag].setTitleColor(.white, for: .normal)
            page = 1
            getNetworkData(sort: CategoryEng.dsc.rawValue)
            category = CategoryEng.dsc.rawValue
        case 3:
            buttonList[sender.tag].backgroundColor = .darkGray
            buttonList[sender.tag].setTitleColor(.white, for: .normal)
            page = 1
            getNetworkData(sort: CategoryEng.asc.rawValue)
            category = CategoryEng.asc.rawValue
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
        CollecionViewSetting()
        buttonList[0].backgroundColor = .darkGray
        buttonList[0].setTitleColor(.white, for: .normal)
        configurehierarchy()
        configureLayout()
        getNetworkData(sort: "sim")
    }
    override func viewDidLayoutSubviews() {
        navigationController?.navigationBar.layer.addBorder([.bottom], color: .systemGray4, width: 1)
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    func CollecionViewSetting() {
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
    func getNetworkData(sort: String) {
        Network.shared.callRequest(sort: sort, page: page) { result in
            switch result {
            case .success(let value):
                if self.page == 1 {
                    Variable.mySearch = value
                } else {
                    Variable.mySearch.append(contentsOf: value)
                }
                self.collectionView.reloadData()
                self.numberOfSearch.text = "\(Network.contentCount.formatted())개의 검색결과"
                if self.page == 1 {
                    self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
                }
            case .failure(_):
                self.showAlert(title: AlertMention.connectionError.rawValue, message: AlertMention.network.rawValue)
                self.numberOfSearch.text = AlertMention.network.rawValue
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
        Variable.like = UserDefaults.standard.bool(forKey: "\(Variable.mySearch[indexPath.item].productId)")
        cell.configureCell(data: indexPath)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ProductViewController()
        vc.navigationItem.title = Variable.mySearch[indexPath.item].title
        Variable.searchItem = Variable.mySearch[indexPath.item].link
        Variable.productNumber = Variable.mySearch[indexPath.item].productId
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension ResultViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for item in indexPaths {
            if Variable.mySearch.count - 6 == item.row {
                page += 1
                switch category {
                case CategoryEng.sim.rawValue:
                    getNetworkData(sort: "sim")
                case CategoryEng.date.rawValue:
                    getNetworkData(sort: "date")
                case CategoryEng.dsc.rawValue:
                    getNetworkData(sort: "dsc")
                case CategoryEng.asc.rawValue:
                    getNetworkData(sort: "asc")
                default:
                    getNetworkData(sort: "sim")
                }
            }
        }
    }
}
