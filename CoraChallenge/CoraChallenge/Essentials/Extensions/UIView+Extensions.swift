//
//  UIView+Extensions.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 22/06/24.
//

import UIKit

extension UIView {
    
    func setSize(_ size: CGFloat) {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: size),
            widthAnchor.constraint(equalToConstant: size)
        ])
    }
    
    func setHeight(_ height: CGFloat) {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
}
