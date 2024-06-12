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
        #warning("remove color")
        imageView.backgroundColor = .green
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var homeImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "home-image"))
        #warning("remove color")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Conta Digital PJ\nPoderosamente simples"
        label.numberOfLines = 0
    #warning("make style")
        return label
    }()
    
//    private lazy var subTitleLabel: UILabel = {
//        let label = UILabel()
//    #warning("make style")
//        return label
//    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Sua empresa livre burocracias e de taxas para gerar boletos, fazer transferências e pagamentos."
        label.numberOfLines = 0
    #warning("make style")
        return label
    }()
    
    private lazy var textStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.axis = .vertical
        stackView.spacing = HomeMetrics.Padding.regular
        stackView.backgroundColor = .green
        return stackView
    }()
    
    private lazy var signUpButton: CoraButton = {
        //botaozao
        let button = CoraButton()
        return button
    }()
    
    private lazy var signInButton: CoraButton = {
        // ja sou cliente
        let button = CoraButton()
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
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInterface()
        setupConstraints()
    }
    
    // MARK: - View Setup
    
    
    private func setupInterface() {
        view.backgroundColor = .systemPink
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
    
    // MARK: - Private Methods
}
