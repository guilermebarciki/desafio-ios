//
//  TransactionDetailComponent.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 24/06/24.
//

import UIKit

final class TransactionDetailComponent: UIView {
    
    private lazy var firstLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Neutral.black.color
        label.font = .regular(.body2)
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var secondLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Neutral.black.color
        label.font = .bold(.body1)
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstLabel, secondLabel, descriptionStackView])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInterface()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupInterface() {
        addSubview(stackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func fill(firstText: String? = nil, secondText: String? = nil, contentTexts: [String]? = nil) {
        if let firstText = firstText {
            firstLabel.text = firstText
            firstLabel.isHidden = false
        }
        
        if let secondText = secondText {
            secondLabel.text = secondText
            secondLabel.isHidden = false
        }
        
        addContent(contentTexts: contentTexts)
        
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    private func addContent(contentTexts: [String]?) {
        descriptionStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        contentTexts?.forEach { text in
            let label = UILabel()
            label.font = .regular(.body2)
            label.textColor = Colors.Neutral.gray01.color
            label.text = text
            label.translatesAutoresizingMaskIntoConstraints = false
            descriptionStackView.addArrangedSubview(label)
        }
    }
}
