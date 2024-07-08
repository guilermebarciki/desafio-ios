import UIKit

private final class CustomSegmentedButton: UIButton {
    override var isSelected: Bool {
        didSet {
            updateButtonStyle()
        }
    }
    
    var buttonTitle: String? {
        didSet {
            setTitle(buttonTitle, for: .normal)
            updateIndicatorConstraints()
        }
    }
    
    private let selectionIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.Brand.primary.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var indicatorWidthConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupIndicator()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupIndicator()
    }
    
    private func setupIndicator() {
        addSubview(selectionIndicatorView)
        
        indicatorWidthConstraint = selectionIndicatorView.widthAnchor.constraint(equalToConstant: 0)
        
        if let indicatorWidthConstraint = indicatorWidthConstraint {
            NSLayoutConstraint.activate([
                selectionIndicatorView.heightAnchor.constraint(equalToConstant: 1),
                selectionIndicatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
                selectionIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
                indicatorWidthConstraint
            ])
        }
        self.setHeight(20)
        selectionIndicatorView.isHidden = true
    }
    
    private func updateButtonStyle() {
        if isSelected {
            applySelectedStyle()
            selectionIndicatorView.isHidden = false
        } else {
            applyDefaultStyle()
            selectionIndicatorView.isHidden = true
        }
    }
    
    private func applyDefaultStyle() {
        setTitleColor(Colors.Neutral.gray01.color, for: .normal)
        titleLabel?.font = .regular(.body2)
    }
    
    private func applySelectedStyle() {
        setTitleColor(Colors.Brand.primary.color, for: .normal)
        titleLabel?.font = .bold(.body2)
    }
    
    private func updateIndicatorConstraints() {
        guard let titleLabel = titleLabel,
              let indicatorWidthConstraint = indicatorWidthConstraint else { return }
        
        NSLayoutConstraint.deactivate([indicatorWidthConstraint])
        self.indicatorWidthConstraint = selectionIndicatorView.widthAnchor.constraint(equalTo: titleLabel.widthAnchor)
        if let newConstraint = self.indicatorWidthConstraint {
            NSLayoutConstraint.activate([newConstraint])
        }
        
        layoutIfNeeded()
    }
}


protocol CustomSegmentedControlDelegate: AnyObject {
    func selectionDidChange(to index: Int)
}

final class CustomSegmentedControl: UIView {
    weak var delegate: CustomSegmentedControlDelegate?
    private var segmentButtons = [CustomSegmentedButton]()
    
    
    
    private let buttonStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 32
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private(set) var selectedSegmentIndex = 0 {
        didSet {
            updateSelectedSegment()
            delegate?.selectionDidChange(to: selectedSegmentIndex)
        }
    }
    
    init(buttonTitles: [String], initialSelectedIndex: Int = 0) {
        super.init(frame: .zero)
        configureButtons(with: buttonTitles, selectedIndex: initialSelectedIndex)
        setupControlView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setupControlView() {
        addSubview(buttonStackView)
        
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: topAnchor),
            buttonStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            buttonStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            buttonStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func configureButtons(with titles: [String], selectedIndex: Int) {
        titles.enumerated().forEach { index, title in
            let button = CustomSegmentedButton()
            button.buttonTitle = title
            button.isSelected = index == selectedIndex
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            segmentButtons.append(button)
            buttonStackView.addArrangedSubview(button)
        }
        
        self.selectedSegmentIndex = selectedIndex
        updateSelectedSegment()
    }
    
    @objc private func buttonTapped(_ sender: CustomSegmentedButton) {
        guard let index = segmentButtons.firstIndex(of: sender) else { return }
        selectedSegmentIndex = index
    }
    
    private func updateSelectedSegment() {
        segmentButtons.forEach { $0.isSelected = false }
        segmentButtons[selectedSegmentIndex].isSelected = true
    }
    
}
