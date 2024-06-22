//
//  HomeViewController.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 11/06/24.
//

import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = HomeImages.General.logo.getImage()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var homeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = HomeImages.General.banner.getImage()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .bold(.title1)
        label.text = HomeStrings.View.title.localized
        label.textColor = Colors.Neutral.white.color
        label.numberOfLines = 0
        return label
    }()
    

#warning("solve subtitle")
//    private lazy var subTitleLabel: UILabel = {
//        let label = UILabel()
//        return label
//    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .regular(.body1)
        label.text = HomeStrings.View.description.localized
        label.textColor = Colors.Neutral.white.color
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var textStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.axis = .vertical
        stackView.spacing = HomeMetrics.Padding.regular
        return stackView
    }()
    
    private lazy var signUpButton: CoraButton = {
        let button = CoraButton(
            title: HomeStrings.View.signupButton.localized,
            size: .big,
            style: .secondary,
            icon: HomeImages.General.logo.getImage()
        )
        return button
    }()
    
    private lazy var signInButton: CoraButton = {
        let button = CoraButton(
            title: HomeStrings.View.signinButton.localized,
            size: .regular,
            style: .simple,
            action: {
                self.router?.navigateSignIn()
            }
        )
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [signUpButton, signInButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.axis = .vertical
        stackView.spacing = HomeMetrics.Spacing.regular
        return stackView
    }()
    
    private lazy var router: HomeRouter? = {
        guard let navigationController = navigationController else { return nil }
        return HomeRouter(with: navigationController)
    }()
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInterface()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - View Setup
    
    
    private func setupInterface() {
        view.backgroundColor = Colors.Brand.primary.color
        view.addSubview(homeImage)
        view.addSubview(logoImage)
        view.addSubview(textStackView)
        view.addSubview(buttonStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            homeImage.topAnchor.constraint(equalTo: view.topAnchor),
            homeImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            homeImage.bottomAnchor.constraint(equalTo: textStackView.topAnchor, constant: -HomeMetrics.Padding.regular)
        ])
        
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                           constant: HomeMetrics.Padding.big),
            logoImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: HomeMetrics.Padding.big)
        ])
        
        NSLayoutConstraint.activate([
            textStackView.topAnchor.constraint(equalTo: view.centerYAnchor),
            textStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -HomeMetrics.Padding.regular),
            textStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: HomeMetrics.Padding.regular),
        ])
        
        NSLayoutConstraint.activate([
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -HomeMetrics.Padding.regular),
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: HomeMetrics.Padding.regular),
            buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -HomeMetrics.Padding.regular)
        ])
        
    }
    
}
