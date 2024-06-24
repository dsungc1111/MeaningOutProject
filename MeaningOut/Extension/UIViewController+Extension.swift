//
//  UIViewController+Extension.swift
//  MeaningOut
//
//  Created by 최대성 on 6/24/24.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: AlertMention.networkChecking.rawValue, style: .default)
        alert.addAction(okButton)
        present(alert, animated: true)
    }
    
}
