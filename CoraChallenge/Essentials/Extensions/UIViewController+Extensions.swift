//
//  UIViewController+Extensions.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 22/06/24.
//

import Foundation
import UIKit

extension UIViewController {
    
    func dismissKeyboardWhenTappedOutside() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func displayAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
}


private var activityIndicatorAssociationKey: UInt8 = 0

extension UIViewController {
    
    private var activityIndicator: UIActivityIndicatorView {
        get {
            if let indicator = objc_getAssociatedObject(self, &activityIndicatorAssociationKey) as? UIActivityIndicatorView {
                return indicator
            }
            let indicator = UIActivityIndicatorView(style: .large)
            indicator.translatesAutoresizingMaskIntoConstraints = false
            indicator.hidesWhenStopped = true
            objc_setAssociatedObject(self, &activityIndicatorAssociationKey, indicator, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return indicator
        }
        set {
            objc_setAssociatedObject(self, &activityIndicatorAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func showLoadingIndicator() {
        if activityIndicator.superview == nil {
            view.addSubview(activityIndicator)
            NSLayoutConstraint.activate([
                activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        }
        
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
    }
    
    
    func hideLoadingIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
        }
    }
    
}
