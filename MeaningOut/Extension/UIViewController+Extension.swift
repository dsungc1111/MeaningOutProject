//
//  UIViewController+Extension.swift
//  MeaningOut
//
//  Created by 최대성 on 6/24/24.
//

import UIKit

extension UIViewController {
    
    func showAlertNetwork(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: AlertMention.networkChecking.rawValue, style: .default)
        alert.addAction(okButton)
        present(alert, animated: true)
    }
    
    func showAlertReset(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: AlertMention.networkChecking.rawValue, style: .default) {_ in
            if UserDefaultManager.myBasket.count != 0 {
                for i in 0..<UserDefaultManager.myBasket.count {
                    UserDefaults.standard.setValue(false, forKey: UserDefaultManager.myBasket[i])
                }
            }
            UserDefaultManager.user = ""
            UserDefaultManager.profileImage = ""
            UserDefaultManager.searchList = []
            UserDefaultManager.myBasket = []
            let vc = UINavigationController(rootViewController: OnBoardingViewController())
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
        let cancelButton = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(cancelButton)
        alert.addAction(okButton)
        present(alert, animated: true)
    }
}
