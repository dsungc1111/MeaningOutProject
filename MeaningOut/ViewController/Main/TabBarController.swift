//
//  UITabBarController.swift
//  MeaningOut
//
//  Created by 최대성 on 6/14/24.
//

import UIKit


final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = UIColor.mainColor
        tabBar.unselectedItemTintColor = .gray
        
        let search = SearchViewController()
        let nav1 = UINavigationController(rootViewController: search)
        nav1.tabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        
        let birthday = SettingViewController()
        let nav2 = UINavigationController(rootViewController: birthday)
        nav2.tabBarItem = UITabBarItem(title: "설정", image: UIImage(systemName: "person"), tag: 1)
        setViewControllers([nav1, nav2], animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tabBar.layer.addBorder([.top], color: .lightGray, width: 1)
    }
   
    
}
