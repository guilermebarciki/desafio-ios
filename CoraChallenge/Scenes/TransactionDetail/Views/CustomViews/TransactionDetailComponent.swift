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
        label.font = .bold(.title2)
        label.isHidden = true
        return label
    }()
    
    private lazy var secondLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Neutral.black.color
        label.font = .bold(.title2)
        label.isHidden = true
        return label
    }()
    
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstLabel, secondLabel, descriptionStackView])
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var descriptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
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
    
    func fill(firstText: String?, secondText: String?, contentTexts: [String]?) {
        if let firstText {
            firstLabel.text = firstText
            firstLabel.isHidden = false
        }
        
        if let secondText {
            secondLabel.text = secondText
            secondLabel.isHidden = false
        }
        
        addContent(contentTexts: contentTexts)
    }
    
    private func addContent(contentTexts: [String]?) {
        
        contentTexts?.forEach { text in
            let label = UILabel()
            label.font = .regular(.body2)
            label.textColor = Colors.Neutral.gray01.color
            label.text = text
            descriptionStackView.addArrangedSubview(label)
        }
        
    }
    
}
