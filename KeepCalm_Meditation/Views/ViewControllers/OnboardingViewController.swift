import UIKit

class OnboardingViewController: UIViewController {
    
    private let currentDeviceHeight = UIScreen.main.bounds.height
    
    // MARK: - UI Elements
    
    private let backgroundImage : UIImageView = {
        let bg = UIImageView()
        bg.image = UIImage(named: K.LoginSection.launchBackgroundImg)
        bg.contentMode = .scaleToFill
        bg.translatesAutoresizingMaskIntoConstraints = false
        return bg
    }()
    
    private let logoImage : UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: K.mainLogoImage)
        logo.contentMode = .scaleAspectFill
        logo.heightAnchor.constraint(equalToConstant: 180).isActive = true
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
    private let wellcomeLabel : UILabel = {
        let lb = UILabel()
        lb.font = .alegreyaBold34()
        lb.textColor = .white
        lb.textAlignment = .center
        lb.text = "WELCOME"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let notiveLabel : UILabel = {
        let lb = UILabel()
        lb.font = .alegreyaSansMedium20()
        lb.textAlignment = .center
        lb.numberOfLines = 0
        lb.textColor = .white
        lb.text = "Do meditation. Stay focused. Live a healthy life."
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let labelsStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var loginButton = ReusableButton(style: .loginEmail)
    
    private let bottomLabel : UILabel = {
        let lb = UILabel()
        lb.font = .alegreyaSansRegular20()
        lb.textColor = .white
        lb.textAlignment = .left
        lb.text = "Don’t have an account?"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()

    private lazy var signUpButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("Sign Up", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .alegreyaSansBold20()
        btn.addTarget(self, action: #selector(signUpTaped(_:)), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let lastLineStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let bottomStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 18
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let mainStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalCentering
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addButtonsMethods()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupConstraints()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    // MARK: - Buttons Methods
    
    @objc func loginPressed() {
        self.navigationController?.pushViewController(SignInViewController(), animated: true)
    }
    
    @objc func signUpTaped(_ sender: UIButton) {
        sender.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.signUpButton.alpha = 1
        }
    }
    
    
    // MARK: - Setup UI
    
    private func addButtonsMethods() {
        loginButton.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
    }
    
    private func addSubviews() {
        view.addSubview(backgroundImage)
        view.addSubview(mainStack)
        mainStack.addArrangedSubview(logoImage)
        mainStack.addArrangedSubview(labelsStack)
        mainStack.addArrangedSubview(bottomStack)
        labelsStack.addArrangedSubview(wellcomeLabel)
        labelsStack.addArrangedSubview(notiveLabel)
        bottomStack.addArrangedSubview(loginButton)
        bottomStack.addArrangedSubview(lastLineStack)
        lastLineStack.addArrangedSubview(bottomLabel)
        lastLineStack.addArrangedSubview(signUpButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            currentDeviceHeight <= 568 ? mainStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 50) : ((currentDeviceHeight <= 667) ? mainStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 150) : mainStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 250)),
            
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -50)
        ])
    }
}

