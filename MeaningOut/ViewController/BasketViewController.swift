//
//  BasketPageViewController.swift
//  MeaningOut
//
//  Created by 최대성 on 6/23/24.
//

import UIKit

class BasketViewController: UIViewController {

    var page = 1
    
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
        CollecionViewSetting()
        view.backgroundColor = .white
        configureHeirarchy()
        configureLayout()
    }
    
    func configureHeirarchy() {
        view.addSubview(collectionView)
    }
    func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.verticalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    func CollecionViewSetting() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.prefetchDataSource = self
        collectionView.register(ResultCollectionViewCell.self, forCellWithReuseIdentifier: ResultCollectionViewCell.identifier)
    }
    func getNetworkData(sort: String) {
        Network.shared.callRequest(sort: sort, page: page) { result in
            switch result {
            case .success(let value):
                if self.page == 1{
                    Variable.mySearch = value
                } else {
                    Variable.mySearch.append(contentsOf: value)
                }
                self.collectionView.reloadData()
                if self.page == 1{
                    self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
                }
            case .failure(_):
                let alert = UIAlertController(title: AlertMention.connectionError.rawValue, message: AlertMention.network.rawValue, preferredStyle: .alert)
                let okButton = UIAlertAction(title: AlertMention.networkChecking.rawValue, style: .default)
                alert.addAction(okButton)
                self.present(alert, animated: true)
            }
        }
        
    }
}
extension BasketViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return UserDefaultManager.myBasket.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultCollectionViewCell.identifier, for: indexPath) as? ResultCollectionViewCell else { return ResultCollectionViewCell() }
        
        Variable.like = UserDefaults.standard.bool(forKey: "\(UserDefaultManager.myBasket[indexPath.item])")
        
        cell.configureCell(data: indexPath)
        
        return cell
    }
    
    
}

extension BasketViewController: UICollectionViewDataSourcePrefetching  {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for item in indexPaths {
            if Variable.mySearch.count - 6 == item.row {
                page += 1
                getNetworkData(sort: "sim")
                
            }
        }
    }
    
    
}
