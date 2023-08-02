import UIKit

class MoodBoosterViewController: UIViewController {
    
    // MARK: -  UI Elements
    
    private lazy var contentStackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalCentering
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var noticeLabel : UILabel = {
        let lb = UILabel()
        lb.font = .alegreyaSansRegular25()
        lb.textColor = .white
        lb.textAlignment = .center
        lb.numberOfLines = 0
        lb.text = "dfsddfsjfdshk dshfsdhkfhi dsfghdshf dvh cxhfd cvsdfghvwe csgscg"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var authorLabel : UILabel = {
        let lb = UILabel()
        lb.font = .alegreyaSansBold16()
        lb.textColor = .systemBlue
        lb.textAlignment = .left
        lb.text = "dfsdfsdf dfsfds"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var pervoiseButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        btn.tintColor = .white
        btn.heightAnchor.constraint(equalToConstant: 80).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 80).isActive = true
        btn.contentMode = .scaleToFill
        btn.addTarget(self, action: #selector(pervoicePressed), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var nextButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        btn.tintColor = .white
        btn.heightAnchor.constraint(equalToConstant: 80).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 80).isActive = true
        btn.contentMode = .scaleToFill
        btn.addTarget(self, action: #selector(nextPressed), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let buttonStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        stack.spacing = 30
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    // MARK: - LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        view.backgroundColor = .mainBackgroundColor()
        addSubviews()
        setupConstraints()
    }
    
    
    // MARK: - Buttons Methods
    
    @objc func pervoicePressed() {}
    
    @objc func nextPressed() {}
    
    
    // MARK: - Setup UI
    
    private func addSubviews() {
        view.addSubview(contentStackView)
        contentStackView.addArrangedSubview(noticeLabel)
        contentStackView.addArrangedSubview(authorLabel)
        contentStackView.addArrangedSubview(buttonStack)
        buttonStack.addArrangedSubview(pervoiseButton)
        buttonStack.addArrangedSubview(nextButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            contentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        ])
    }

}
