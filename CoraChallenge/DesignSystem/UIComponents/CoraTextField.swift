//
//  CoraTextField.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 22/06/24.
//

import UIKit

final class CoraTextField: UITextField {
    
    private var isVisible: Bool = false
    
    private lazy var togglePasswordButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        button.setImage(GlobalImages.Icons.eyeHidden.getImage(), for: [])
        button.tintColor = Colors.Brand.primary.color
        #warning("metrics")
        button.setSize(32)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDefaultConfiguration()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupDefaultConfiguration()
    }
    
    init(isPasswordField: Bool = false) {
           super.init(frame: .zero)
           setupDefaultConfiguration(isPasswordField: isPasswordField)
       }
    
    private func setupDefaultConfiguration(isPasswordField: Bool = false) {
        keyboardType = .numberPad
        textColor = Colors.Neutral.black.color
        font = .bold(.title2)
        tintColor = Colors.Brand.primary.color
        
        if isPasswordField {
            rightView = togglePasswordButton
            rightViewMode = .always
            isSecureTextEntry = true
        }
    }
    
    private func consistIconColor() {
        togglePasswordButton.tintColor = isSecureTextEntry ? Colors.Brand.primary.color : Colors.Neutral.gray02.color
    }
    
    @objc private func togglePasswordVisibility() {
        isSecureTextEntry.toggle()
        consistIconColor()
       }
    
}

