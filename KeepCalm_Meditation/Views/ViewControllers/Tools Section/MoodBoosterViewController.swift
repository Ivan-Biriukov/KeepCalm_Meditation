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
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var authorLabel : UILabel = {
        let lb = UILabel()
        lb.font = .alegreyaSansBold16()
        lb.textColor = .systemBlue
        lb.textAlignment = .left
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    
    private lazy var nextButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("Next", for: .normal)
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
        bindQouteViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        QuotesViewModel.shared.fetchQoute()
    }
    
    
    // MARK: - Buttons Methods
    
    @objc func pervoicePressed() {}
    
    @objc func nextPressed() {
        QuotesViewModel.shared.fetchQoute()
    }
    
    
    // MARK: - Setup UI
    
    private func addSubviews() {
        view.addSubview(contentStackView)
        contentStackView.addArrangedSubview(noticeLabel)
        contentStackView.addArrangedSubview(authorLabel)
        contentStackView.addArrangedSubview(buttonStack)
        view.addSubview(nextButton)
      //  buttonStack.addArrangedSubview(nextButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            contentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200)
        ])
    }
    
    func bindQouteViewModel() {
        QuotesViewModel.shared.currentQoute.bind { data in
            DispatchQueue.main.async {
                self.noticeLabel.text = data.quoteText
                self.authorLabel.text = data.quoteAuthor
            }
        }
    }

}
