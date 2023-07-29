import UIKit

class SignInViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private let backgroundImage : UIImageView = {
        let bg = UIImageView()
        bg.image = UIImage(named: K.LoginSection.singinBackgroundImg)
        bg.contentMode = .scaleToFill
        bg.translatesAutoresizingMaskIntoConstraints = false
        return bg
    }()
    
    private let topStack = LoginTopStack(style: .signIn)
    private let emailTextField = ReusableTextField(style: .email)
    private let passwordTextField = ReusableTextField(style: .password)
    
    private let fieldsStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var recoverPasswordButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("Forgot Password?", for: .normal)
        btn.setTitleColor(.grayText(), for: .normal)
        btn.titleLabel?.font = .alegreyaSansRegular14()
        btn.addTarget(self, action: #selector(recoverButtonPressed(_:)), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    private lazy var loginButton = ReusableButton(style: .login)

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

    private let bottomButtonsStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
        setupButtons()
        hideKeyboardWhenTappedAround()
        configureTextFields()
    }
    
    // MARK: - Buttons Methods
    
    @objc func recoverButtonPressed(_ sender: UIButton) {
        sender.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.alpha = 1
        }
    }
    
    @objc func loginPressed() {
        
    }
    
    @objc func signUpTaped(_ sender: UIButton) {
        sender.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.alpha = 1
        }
    }
    
    // MARK: - SetupUI
    
    private func setupButtons() {
        loginButton.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
    }
    
    private func configureTextFields() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func addSubviews() {
        view.addSubview(backgroundImage)
        view.addSubview(topStack)
        view.addSubview(fieldsStack)
        fieldsStack.addArrangedSubview(emailTextField)
        fieldsStack.addArrangedSubview(passwordTextField)
        view.addSubview(recoverPasswordButton)
        view.addSubview(bottomButtonsStack)
        bottomButtonsStack.addArrangedSubview(loginButton)
        bottomButtonsStack.addArrangedSubview(lastLineStack)
        lastLineStack.addArrangedSubview(bottomLabel)
        lastLineStack.addArrangedSubview(signUpButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            K.DeviceSizes.currentDeviceHeight <= 568 ? topStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 25) : ((K.DeviceSizes.currentDeviceHeight <= 667) ? topStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 55) : topStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 105)),
            
            topStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 27),
            topStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -27),
            
            fieldsStack.topAnchor.constraint(equalTo: topStack.bottomAnchor, constant: 20),
            fieldsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            fieldsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            recoverPasswordButton.topAnchor.constraint(equalTo: fieldsStack.bottomAnchor, constant: 10),
            recoverPasswordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            K.DeviceSizes.currentDeviceHeight <= 568 ? bottomButtonsStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25) : ((K.DeviceSizes.currentDeviceHeight <= 667) ? bottomButtonsStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -75) : bottomButtonsStack.topAnchor.constraint(equalTo: recoverPasswordButton.bottomAnchor, constant: 30)),
            bottomButtonsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomButtonsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

// MARK: - TextField Delegate

extension SignInViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.endEditing(true)
        return true
    }
}
