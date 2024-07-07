//
//  BasketPageViewController.swift
//  MeaningOut
//
//  Created by 최대성 on 6/23/24.
//

import UIKit
import SnapKit
import RealmSwift

class BasketViewController: UIViewController {
    
    let realm = try! Realm()
    var page = 1
    private var userLike = false
    lazy var list = realm.objects(RealmTable.self).filter("isLike == %@", true)
    
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
//        collectionView.prefetchDataSource = self
        collectionView.register(BasketCollectionViewCell.self, forCellWithReuseIdentifier: BasketCollectionViewCell.identifier)
    }
}
extension BasketViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BasketCollectionViewCell.identifier, for: indexPath) as? BasketCollectionViewCell else { return BasketCollectionViewCell() }
     
        
        cell.configureCell(data: indexPath)
        cell.companyNameLabel.text = "dsf"

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
