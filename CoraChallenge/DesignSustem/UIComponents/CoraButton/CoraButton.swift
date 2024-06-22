import UIKit

final class CoraButton: UIButton {
    
    private var isActive: Bool = true {
        didSet {
            isEnabled = isActive
            updateAppearance()
        }
    }
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = CoraButtonMetrics.Padding.small
        stackView.isUserInteractionEnabled = false
        return stackView
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: CoraButtonMetrics.Icon.size).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: CoraButtonMetrics.Icon.size).isActive = true
        return imageView
    }()
    
    private var style: Style
    
    init(title: String, size: Size, style: Style, icon: UIImage? = nil, isActive: Bool = true, action: (() -> Void)? = nil) {
        self.style = style
        self.isActive = isActive
        super.init(frame: .zero)
        isEnabled = isActive
        setupButton(title: title, size: size, style: style, icon: icon)
        setupAction(with: action)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


// MARK: - Setup

extension CoraButton {
    
    private func setupButton(title: String, size: Size, style: Style, icon: UIImage?) {
        setupTitle(title: title, size: size, style: style)
        
        backgroundColor = style.backgroundColor
        layer.cornerRadius = size.cornerRadius
        translatesAutoresizingMaskIntoConstraints = false
        
        if let icon = icon {
            setupWithIcon(icon: icon)
        }
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: size.height),
        ])
    }
    
    private func setupTitle(title: String, size: Size, style: Style) {
        setTitle(title, for: .normal)
        setTitleColor(style.titleColor, for: .normal)
        titleLabel?.font = size.font
    }
    
    private func setupWithIcon(icon: UIImage) {
        iconImageView.image = icon
        
        if let titleLabel {
            stackView.addArrangedSubview(titleLabel)
        }
        stackView.addArrangedSubview(iconImageView)
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: CoraButtonMetrics.Padding.regular),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -CoraButtonMetrics.Padding.regular)
        ])
    }
    
    private func setupAction(with action: (() -> Void)?) {
           guard let action = action else { return }
           addAction(UIAction { _ in
               action()
           }, for: .touchUpInside)
       }
    
    private func updateAppearance() {
        backgroundColor = isEnabled ? style.backgroundColor : Colors.Neutral.gray02.color
    }
    
}

// MARK: - Public Methods

extension CoraButton {
    
    func setActive(_ active: Bool) {
        isActive = active
    }
    
}


// MARK: - Configuration Properties

extension CoraButton {
    
    enum Size {
        case regular
        case big
        
        var height: CGFloat {
            switch self {
            case .regular:
                return CoraButtonMetrics.Height.regular
            case .big:
                return CoraButtonMetrics.Height.big
            }
        }
        
        var cornerRadius: CGFloat {
            switch self {
            case .regular:
                return CoraButtonMetrics.Radius.regular
            case .big:
                return CoraButtonMetrics.Radius.big
            }
        }
        
        var font: UIFont {
            switch self {
            case .regular:
                return .bold(.body2)
            case .big:
                return .bold(.body1)
            }
        }
    }
    
    enum Style {
        
        case primary
        case secondary
        case simple
        
        var backgroundColor: UIColor {
            switch self {
            case .primary:
                return Colors.Brand.primary.color
            case .secondary:
                return Colors.Neutral.white.color
            case .simple:
                return .clear
            }
        }
        
        var titleColor: UIColor {
            switch self {
            case .primary, .simple:
                return Colors.Neutral.white.color
            case .secondary:
                return Colors.Brand.primary.color
            }
        }
    }
}
