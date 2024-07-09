//
//  TransactionListViewController.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 23/06/24.
//

import UIKit

class TransactionListViewController: UIViewController, CoraNavigationStylable {
    
    
    
    // MARK: - Properties
    
    
    private lazy var segmentedControl: CustomSegmentedControl = {
        let items = TransactionSegment.allCases.map { $0.title }
        let control = CustomSegmentedControl(buttonTitles: items)
        control.delegate = self
        return control
    }()
    
    private lazy var filterButton: UIButton = {
        let button = UIButton()
        button.setImage(GlobalImages.Icons.filter.getImage(), for: .normal)
        button.tintColor = Colors.Brand.primary.color
        button.setSize(GlobalMetrics.Icon.regularSize)
        return button
    }()
    
    private lazy var topStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [segmentedControl, filterButton])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = GlobalMetrics.Padding.regular
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: GlobalMetrics.Padding.regular,
                                               left: GlobalMetrics.Padding.big,
                                               bottom:  GlobalMetrics.Padding.regular,
                                               right: GlobalMetrics.Padding.big)
        
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
        tableView.sectionFooterHeight = TransactionListMetrics.Tableview.footerHeight
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
        setupTableView()
        viewModel.fetchTransactionList()
    }
    
}


// MARK: - Setup Methods

extension TransactionListViewController {
    
    private func setupInterface() {
        title = TransactionListStrings.View.title.localized
        view.backgroundColor = Colors.Neutral.white.color
        
        view.addSubview(topStackView)
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topStackView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupTableView() {
        tableView.register(TransactionItemTableViewCell.self, forCellReuseIdentifier: TransactionItemTableViewCell.identifier)
    }
    
}


// MARK: - Private methods

extension TransactionListViewController {
    
    private func transactionSelected(at indexPath: IndexPath) {
        guard let navigationData = viewModel.getTransactionDetailNavigationData(at: indexPath) else {
            return
        }
        router?.navigateToTransactionDetail(with: navigationData)
    }
    
}


// MARK: - Public methods

extension TransactionListViewController {}


// MARK: - Actions

extension TransactionListViewController {}


// MARK: - TransactionListDelegate

extension TransactionListViewController: TransactionListDelegate {
    
    func fetchListFail(error: String) {
        DispatchQueue.main.async {
            self.displayAlert(title: "Erro", message: error)
        }
    }
    
    func startLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.showLoadingIndicator()
        }
    }
    
    func stopLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.hideLoadingIndicator()
        }
    }
    
    func updateView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}


// MARK: - TableView Methods

extension TransactionListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getDaysCount()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getTransactionsCount(at: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TransactionItemTableViewCell = .createCell(tableView: tableView, indexPath: indexPath)
        let fill = viewModel.getTransactionFill(indexPath: indexPath)
        cell.fill(with: fill)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return transactionSelected(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let fill = viewModel.getTransactionDateFill(for: section)
        let view = DateHeaderView(fill: fill)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        TransactionListMetrics.Tableview.headerHeight
    }
    
}


extension TransactionListViewController: CustomSegmentedControlDelegate {
    
    func selectionDidChange(to index: Int) {
        viewModel.filterTransaction(at: index)
    }
    
}
