//
//  SelectProfileViewController.swift
//  MeaningOut
//
//  Created by 최대성 on 6/13/24.
//

import UIKit

class SelectViewController: UIViewController {

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: CollectionViewLayout())
 
    static func CollectionViewLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewFlowLayout()
        let sectionSpacing: CGFloat = 30
        let cellSpacing: CGFloat = 10
        let width = UIScreen.main.bounds.width - (sectionSpacing*2 + cellSpacing*3)
        layout.itemSize = CGSize(width: width/4, height: width/4)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = cellSpacing
        layout.minimumLineSpacing = cellSpacing
        layout.sectionInset = UIEdgeInsets(top: sectionSpacing, left: sectionSpacing, bottom: sectionSpacing, right: sectionSpacing)
        return layout
    }
    
    let profileButton = {
        let button = CustomProfileButton()
        button.setImage(UIImage(named: Variable.profileImage), for: .normal)
        return button
    }()
    let profileCameraLogo = {
        let logo = CameraLogo(frame: .zero)
        return logo
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SelectCollectionViewCell.self, forCellWithReuseIdentifier: SelectCollectionViewCell.identifier)
        collectionView.showsVerticalScrollIndicator = false
        configureHierarchy()
        configureLayout()
    }
    override func viewDidLayoutSubviews() {
        profileButton.layer.cornerRadius = profileButton.frame.width / 2
        profileCameraLogo.layer.cornerRadius = profileCameraLogo.frame.width/2
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        profileButton.setImage(UIImage(named: Variable.profileImage), for: .normal)
    }
    
    func configureHierarchy() {
        view.addSubview(profileButton)
        view.addSubview(profileCameraLogo)
        view.addSubview(collectionView)
    }
    func configureLayout() {
        profileButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.size.equalTo(100)
        }
        profileCameraLogo.snp.makeConstraints { make in
            make.bottom.equalTo(profileButton.snp.bottom).inset(10)
            make.trailing.equalTo(profileButton.snp.trailing)
            make.size.equalTo(30)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(profileButton.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(350)
        }
    }
}


extension SelectViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constant.profileImages.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectCollectionViewCell.identifier, for: indexPath) as? SelectCollectionViewCell else { return SelectCollectionViewCell() }
        cell.profileImageButton.tag = indexPath.row
        
        cell.profileImageButton.addTarget(self, action: #selector(profileIamgeButtonTapped(sender:)), for: .touchUpInside)
        
        cell.configureCell(data: indexPath)
        
        return cell
    }
    
    @objc func profileIamgeButtonTapped(sender: UIButton) {
        
        Variable.profileImage = Constant.profileImages.allCases[sender.tag].rawValue
        
        profileButton.setImage(UIImage(named: Variable.profileImage), for: .normal)
        
        
        collectionView.reloadData()
    }

    
    
    
}
