//
//  TransactionItemCell.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 23/06/24.
//

import UIKit

final class TransactionItemTableViewCell: UITableViewCell {
    
    // MARK: - Identifier
    
    static let identifier = String(describing: TransactionItemTableViewCell.self)
    
    
    // MARK: - Properties
    
    private lazy var iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .top
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return imageView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .regular(.body2)
        return label
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.font = .bold(.body1)
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .regular(.body2)
        label.textColor = Colors.Neutral.gray01.color
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .regular(.body3)
        label.textColor = Colors.Neutral.gray01.color
        label.textAlignment = .right
        return label
    }()
    
    private lazy var textsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [amountLabel, descriptionLabel, nameLabel])
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [iconImage, textsStackView, timeLabel])
        stackView.axis = .horizontal
        stackView.spacing = GlobalMetrics.Padding.regular
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layoutMargins = UIEdgeInsets(top:  GlobalMetrics.Padding.big,
                                               left: GlobalMetrics.Padding.big,
                                               bottom: .zero,
                                               right: GlobalMetrics.Padding.big)
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupInterface()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

// MARK: - Private Methods

extension TransactionItemTableViewCell {
    
    private func setupInterface() {
        contentView.addSubview(mainStackView)
        selectionStyle = .none
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
}




// MARK: - Fill Methods

extension TransactionItemTableViewCell {
    
    func fill(with fill: TransactionItemFill?) {
        guard let fill else { return }
        iconImage.image = fill.icon
        amountLabel.text = fill.formattedValue
        descriptionLabel.text = fill.description
        timeLabel.text = fill.time
        nameLabel.text = fill.name
        iconImage.tintColor = fill.tintColor
        descriptionLabel.textColor = fill.tintColor
        amountLabel.textColor = fill.tintColor 
    }
    
}
