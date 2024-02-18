//
//  UIViewController+Alert.swift
//  NYTimesArticles
//
//  Created by Macbook on 18/02/2024.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String, handler: ((UIAlertAction)->Void)? = nil) {
        let alertController = UIAlertController(title: title, message:
                                                    message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler:handler))
        self.present(alertController, animated: true, completion: nil)
    }
}
