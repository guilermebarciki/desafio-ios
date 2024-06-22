//
//  CoraNavigationStylable.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 22/06/24.
//

import UIKit


protocol CoraNavigationStyling {
    func applyNavigationStyle()
}

extension CoraNavigationStyling where Self: UIViewController {
    func applyNavigationStyle() {
        let font: UIFont = .regular(.body2)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        
        appearance.backgroundColor = Colors.Neutral.gray03.color
        appearance.titleTextAttributes = [
            NSAttributedString.Key.font: font,
            .foregroundColor: Colors.Neutral.gray01.color
        ]
        appearance.largeTitleTextAttributes = [
            .foregroundColor: Colors.Neutral.gray01.color
        ]
        
        UINavigationBar.appearance().tintColor = Colors.Brand.primary.color
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        if let navigationController = navigationController {
            configureNavigationBar(for: navigationController)
        }
    }
    
    private func configureNavigationBar(for navigationController: UINavigationController) {
        navigationController.isNavigationBarHidden = false
        navigationController.navigationBar.prefersLargeTitles = false
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.backIndicatorImage = UIImage(named: "chevronLeft")
        navigationController.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "chevronLeft")
        navigationController.navigationBar.backItem?.backButtonTitle = ""
    }
    
    
}
