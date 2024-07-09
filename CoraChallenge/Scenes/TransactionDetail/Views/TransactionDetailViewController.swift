//
//  TransactionDetailViewController.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 23/06/24.
//

import UIKit

class TransactionDetailViewController: UIViewController, CoraNavigationStylable {
    
    
    // MARK: - Properties
    
    private lazy var viewModel = TransactionDetailViewModel(delegate: self)
    
    private lazy var router: TransactionDetailRouter? = {
        guard let navigationController = navigationController else { return nil }
        return TransactionDetailRouter(with: navigationController)
    }()
    
    private lazy var headerView: TransactionDetailHeaderView = {
        let headerView = TransactionDetailHeaderView()
        return headerView
    }()
    
    private lazy var valueInfoView: TransactionDetailComponent = {
        let headerView = TransactionDetailComponent()
        return headerView
    }()
    
    private lazy var dateInfoView: TransactionDetailComponent = {
        let headerView = TransactionDetailComponent()
        return headerView
    }()
    
    private lazy var senderInfoView: TransactionDetailComponent = {
        let headerView = TransactionDetailComponent()
        return headerView
    }()
    
    private lazy var recipientInfoView: TransactionDetailComponent = {
        let headerView = TransactionDetailComponent()
        return headerView
    }()
    
    private lazy var descriptionInfoView: TransactionDetailComponent = {
        let headerView = TransactionDetailComponent()
        return headerView
    }()
    
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                headerView,
                valueInfoView,
                dateInfoView,
                senderInfoView,
                recipientInfoView,
                descriptionInfoView
            ]
        )
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = GlobalMetrics.Padding.big
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: GlobalMetrics.Padding.extraLarge,
                                               left: GlobalMetrics.Padding.big,
                                               bottom: GlobalMetrics.Padding.big,
                                               right: GlobalMetrics.Padding.big)
        return stackView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var shareButton: CoraButton = {
        let button = CoraButton(
            title: HomeStrings.View.signupButton.localized,
            size: .big,
            style: .primary,
            icon: GlobalImages.Icons.share.getImage()
        )
        return button
    }()
    
    
    // MARK: - View's life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInterface()
        setupConstraints()
        viewModel.fetchTransactionDetail()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyNavigationStyle()
    }
    
}


// MARK: - Setup Methods

extension TransactionDetailViewController {
    
    private func setupInterface() {
        view.backgroundColor = Colors.Neutral.white.color
        title = TransactionDetailStrings.View.title.localized
        view.addSubview(scrollView)
        view.addSubview(shareButton)
        scrollView.addSubview(stackView)
        
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: shareButton.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            shareButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -GlobalMetrics.Padding.big),
            shareButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: GlobalMetrics.Padding.big),
            shareButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
    }
    
}


// MARK: - Navigation

extension TransactionDetailViewController {
    
    func prepareForNavigation(with navigationData: TransactionDetailNavigationData) {
        viewModel.prepareForNavigation(with: navigationData)
    }
    
}


// MARK: - TransactionDetailDelegate

extension TransactionDetailViewController: TransactionDetailDelegate {
    
    @MainActor
    func updateView(with fill: TransactionDetailFill) {
            self.headerView.fill(icon: GlobalImages.Icons.credit.getImage(), title: fill.title)
            self.valueInfoView.fill(firstText: fill.valueTitle, secondText: fill.value)
            self.dateInfoView.fill(firstText: fill.dateTitle, secondText: fill.date)
            self.senderInfoView.fill(firstText: fill.senderTitle, secondText: fill.sender, contentTexts: fill.senderDetails)
            self.recipientInfoView.fill(firstText: fill.recipientTitle, secondText: fill.recipient, contentTexts: fill.recipientDetails)
            self.descriptionInfoView.fill(firstText: fill.descriptionTitle, contentTexts: fill.descriptionDetails)
    }
    
}
