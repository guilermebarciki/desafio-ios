//
//  TransactionListViewController.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 23/06/24.
//

import UIKit

class TransactionListViewController: UIViewController, CoraNavigationStylable {
    
    
    // MARK: - Properties
    
    private lazy var segmentedControl = UIView()
    //    : SegmentedControl = {
    //        let titles = BankStatementSegment.allCases.map { $0.description }
    //        let segmentedControl = SegmentedControl(titles: titles, selectedIndex: 0)
    //        segmentedControl.delegate = self
    //        return segmentedControl
    //    }()
    
    private lazy var filterButton: UIButton = {
        let action = UIAction { _ in print("Filter Clicked") }
        let button = UIButton()
        button.addAction(action, for: .touchUpInside)
        button.setImage(GlobalImages.Icons.eyeHidden.getImage(), for: [])
        button.tintColor = Colors.Brand.primary.color
        button.setSize(24)
        return button
    }()
    
    private lazy var topStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [segmentedControl, filterButton])
        stackView.axis = .horizontal
        stackView.alignment = .center
        //        stackView.spacing = Spacing.space04
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        //        stackView.layoutMargins = UIEdgeInsets(top: .zero,
        //                                               left: Spacing.space04,
        //                                               bottom:  .zero,
        //                                               right: Spacing.space04)
        return stackView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.sectionFooterHeight = 24
        return tableView
    }()
    
    private lazy var viewModel = TransactionListViewModel(delegate: self)
    
    private lazy var router: TransactionListRouter? = {
        guard let navigationController = navigationController else { return nil }
        return TransactionListRouter(with: navigationController)
    }()
    
    
    // MARK: - View's life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInterface()
        setupConstraints()
        applyNavigationStyle()
        viewModel.fetchTransactionList()
        //setrightbuttonbar
    }
    
}


// MARK: - Setup Methods

extension TransactionListViewController {
    
    private func setupInterface() {
        title = "Extrato"
        view.backgroundColor = Colors.Neutral.white.color
        
        view.addSubview(topStackView)
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topStackView.heightAnchor.constraint(equalToConstant: 52)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topStackView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    
}


// MARK: - Navigation

extension TransactionListViewController {
    
    func prepareForNavigation(with navigationData: TransactionListNavigationData) {
        viewModel.prepareForNavigation(with: navigationData)
    }
    
}


// MARK: - Private methods

extension TransactionListViewController {}


// MARK: - Public methods

extension TransactionListViewController {}


// MARK: - Actions

extension TransactionListViewController {}


// MARK: - TransactionListDelegate

extension TransactionListViewController: TransactionListDelegate {
    func updateView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}


// MARK: - TableView Methods

extension TransactionListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4//interactor.numberOfDays()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4//interactor.numberOfTransactions(at: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let identifier = String(describing: StatementItemCell.self)
//        let cell = StatementItemCell(style: .default, reuseIdentifier: identifier)
//        cell.setup(content: interactor.transactionInfo(section: indexPath.section, at: indexPath.row))
        let cell = UITableViewCell()
        cell.textLabel?.text = "fdsfdsfds"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return //interactor.didSelectTransaction(section: indexPath.section, at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UILabel()
        view.backgroundColor = .green
        view.text = viewModel.getTransactionDateFill(for: section)?.formattedDate
        print(viewModel.getTransactionDateFill(for: section)?.formattedDate)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        32
    }
    
}
