//
//  BasketPageViewController.swift
//  MeaningOut
//
//  Created by 최대성 on 6/23/24.
//

import UIKit
import SnapKit
import RealmSwift

final class BasketViewController: UIViewController {
    
    private lazy var searchBar = {
        let search = UISearchBar()
        search.delegate = self
        search.placeholder = "검색"
        search.backgroundColor = .clear
        search.barTintColor = .systemGray6
        search.searchTextField.backgroundColor = .white
        return search
    }()
    private let realm = try! Realm()
    var page = 1
    private var userLike = false
    static var list: Results<RealmTable>!
    

    
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
        Self.list = realm.objects(RealmTable.self).filter("isLike == %@", true)
        configureHeirarchy()
        configureLayout()
    }
    func configureHeirarchy() {
        view.addSubview(searchBar)
        view.addSubview(collectionView)
    }
    func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(40)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(5)
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func CollecionViewSetting() {
        collectionView.dataSource = self
        collectionView.delegate = self
//        collectionView.prefetchDataSource = self
        collectionView.register(BasketCollectionViewCell.self, forCellWithReuseIdentifier: BasketCollectionViewCell.identifier)
    }
}
extension BasketViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Self.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BasketCollectionViewCell.identifier, for: indexPath) as? BasketCollectionViewCell else { return BasketCollectionViewCell() }

        cell.configureCell(data: indexPath)

        return cell
    }

}

//extension BasketViewController: UICollectionViewDataSourcePrefetching  {
//    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
//        for item in indexPaths {
//            if ResultViewController.shoppingList.items.count - 6 == item.row {
//                page += 1
////                getNetworkData(sort: "sim")
//                
//            }
//        }
//    }
//    
//    
//}

extension BasketViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        let filter = realm.objects(RealmTable.self).where {
            $0.productName.contains(searchText, options: .caseInsensitive)
        }
        let result = searchText.isEmpty ? realm.objects(RealmTable.self) : filter
        Self.list = result
        
        collectionView.reloadData()
    }
}
