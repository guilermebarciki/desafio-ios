//
//  SignInViewController.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 22/06/24.
//

import UIKit

final class SignInViewController: UIViewController, CoraNavigationStylable {
    
    
    // MARK: - Properties
    
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Bem-vindo de volta!"
        label.textColor = Colors.Neutral.gray01.color
        label.font = .regular(.body1)
        return label
    }()
    
    private lazy var cpfLabel: UILabel = {
        let label = UILabel()
        label.text = "Qual seu CPF?"
        label.textColor = Colors.Neutral.black.color
        label.font = .bold(.title1)
        return label
    }()
    
    private lazy var textsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [welcomeLabel, cpfLabel])
        stackView.axis = .vertical
        stackView.spacing = GlobalMetrics.Padding.small
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private lazy var navigationButton: CoraButton = {
        let button = CoraButton(
            title: "Próximo",
            size: .regular,
            style: .primary,
            icon: GlobalImages.Icons.next.getImage(),
            isActive: false,
            action: { [weak self] in
                self?.navigateToPassword()
            }
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
#warning("pode fazer um CoraTextField")
    private lazy var cpfTextField: CoraTextField = {
        let textField = CoraTextField()
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var viewModel = SignInViewModel(delegate: self)
    
    private lazy var router: SignInRouter? = {
        guard let navigationController = navigationController else { return nil }
        return SignInRouter(with: navigationController)
    }()
    
    
    // MARK: - View's life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInterface()
        setupConstraints()
        applyNavigationStyle()
        dismissKeyboardWhenTappedOutside()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        cpfTextField.becomeFirstResponder()
    }
    
}


// MARK: - Setup Methods

extension SignInViewController {
    
    private func setupInterface() {
        view.backgroundColor = Colors.Neutral.white.color
        title = SignInStrings.View.title.localized
        
        view.addSubview(textsStackView)
        view.addSubview(cpfTextField)
        view.addSubview(navigationButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            textsStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: GlobalMetrics.Padding.big),
            textsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -GlobalMetrics.Padding.regular),
            textsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: GlobalMetrics.Padding.regular)
        ])
        
        NSLayoutConstraint.activate([
            cpfTextField.topAnchor.constraint(equalTo: textsStackView.bottomAnchor, constant: GlobalMetrics.Padding.extraLarge),
            cpfTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                   constant: -GlobalMetrics.Padding.regular),
            cpfTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                  constant: GlobalMetrics.Padding.regular)
        ])
        
        NSLayoutConstraint.activate([
            navigationButton.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -GlobalMetrics.Padding.big),
            navigationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                       constant: -GlobalMetrics.Padding.regular),
            navigationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                      constant: GlobalMetrics.Padding.regular)
        ])
    }
    
}


// MARK: - Private methods

extension SignInViewController {}


// MARK: - Public methods

extension SignInViewController {}


// MARK: - Actions

extension SignInViewController {
    
    private func navigateToPassword() {
        guard let cpf = viewModel.getCPF() else { return }
        router?.navigateToPassword(with: cpf)
    }
}


// MARK: - SignInDelegate

extension SignInViewController: SignInDelegate {
    func updateNavigationButtonState(isActive: Bool) {
        navigationButton.setActive(isActive)
    }
}


// MARK: - UITextFieldDelegate

extension SignInViewController: UITextFieldDelegate {
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        return CPFMask().shouldChangeCharactersIn(textField, range: range, replacementString: string)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        viewModel.validateCPF(textField.text)
    }
}
