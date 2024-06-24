//
//  DateHeaderView.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 23/06/24.
//

import UIKit

final class DateHeaderView: UIView {
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .regular(.body2)
        label.textColor = Colors.Neutral.gray01.color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    
    init(fill: DateHeaderFill?) {
        super.init(frame: .zero)
        dateLabel.text = fill?.formattedDate ?? ""
        setupInterface()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupInterface() {
        backgroundColor = Colors.Neutral.gray03.color
        addSubview(dateLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            dateLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: GlobalMetrics.Padding.big),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: GlobalMetrics.Padding.big)
        ])
    }
    
    
}


