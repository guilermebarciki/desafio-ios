//  
//  PasswordViewController.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 22/06/24.
//

import UIKit

class PasswordViewController: UIViewController, CoraNavigationStylable {
    
    
    // MARK: - Properties
    
    private lazy var instructionLabel: UILabel = {
        let label = UILabel()
        label.text = "Digite sua senha de acesso!"
        label.textColor = Colors.Neutral.black.color
        label.font = .bold(.title2)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
   
    
    private lazy var passwordTextField: CoraTextField = {
        let textField = CoraTextField(isPasswordField: true)
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        let action = UIAction { _ in print("Forgot Password Clicked") }
        let button = UIButton()
        button.setTitle("Esqueci minha senha", for: .normal)
        button.titleLabel?.font = .regular(.body2)
        button.setTitleColor(Colors.Brand.primary.color, for: .normal)
        button.contentHorizontalAlignment = .left
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var loginButton: CoraButton = {
        let button = CoraButton(
            title: "Próximo",
            size: .regular,
            style: .primary,
            icon: GlobalImages.Icons.next.getImage(),
            isActive: false,
            action: { [weak self] in
//                self?.login()
            }
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var viewModel = PasswordViewModel(delegate: self)
    
    private lazy var router: PasswordRouter? = {
        guard let navigationController = navigationController else { return nil }
        return PasswordRouter(with: navigationController)
    }()
    
    
    // MARK: - View's life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInterface()
        setupConstraints()
        applyNavigationStyle()
        dismissKeyboardWhenTappedOutside()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyNavigationStyle()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        passwordTextField.becomeFirstResponder()
    }
    
}


// MARK: - Setup Methods

extension PasswordViewController {
    
    private func setupInterface() {
        view.backgroundColor = Colors.Neutral.white.color
        title = SignInStrings.View.title.localized
        
        view.addSubview(instructionLabel)
        view.addSubview(passwordTextField)
        view.addSubview(forgotPasswordButton)
        view.addSubview(loginButton)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            instructionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: GlobalMetrics.Padding.big),
            instructionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -GlobalMetrics.Padding.regular),
            instructionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: GlobalMetrics.Padding.regular)
        ])
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: GlobalMetrics.Padding.big),
            passwordTextField.trailingAnchor.constraint(equalTo: instructionLabel.trailingAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: instructionLabel.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            forgotPasswordButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 48),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            forgotPasswordButton.leadingAnchor.constraint(lessThanOrEqualTo: passwordTextField.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -GlobalMetrics.Padding.big),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                       constant: -GlobalMetrics.Padding.regular),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                      constant: GlobalMetrics.Padding.regular)
        ])
        
        
        
    }
    
}


// MARK: - Navigation
    
extension PasswordViewController {
    
    func prepareForNavigation(with navigationData: PasswordNavigationData) {
        viewModel.prepareForNavigation(with: navigationData)
    }
 
}


// MARK: - Private methods
    
extension PasswordViewController {}


// MARK: - Public methods
    
extension PasswordViewController {}


// MARK: - Actions
    
extension PasswordViewController {}


// MARK: - PasswordDelegate

extension PasswordViewController: PasswordDelegate {}


// MARK: - UITextFieldDelegate

extension PasswordViewController: UITextFieldDelegate {
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        return CPFMask().shouldChangeCharactersIn(textField, range: range, replacementString: string)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
//        viewModel.validateCPF(textField.text)
    }
}
