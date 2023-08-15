import UIKit

class SignUpViewController: UIViewController {
    
    private var currentUser = AccountRegistrationModel(succeed: Bool(), title: "", message: "")
    
    // MARK: - UI Elements
    
    private let backgroundImage : UIImageView = {
        let bg = UIImageView()
        bg.image = UIImage(named: K.LoginSection.singinBackgroundImg)
        bg.contentMode = .scaleToFill
        bg.translatesAutoresizingMaskIntoConstraints = false
        return bg
    }()
    
    private let topStack = LoginTopStack(style: .signUp)
    
    private let nameField = ReusableTextField(style: .userName)
    private let emailField = ReusableTextField(style: .email)
    private let passwordField = ReusableTextField(style: .password)
    
    private let fieldsStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 2
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var signupButton = ReusableButton(style: .signUp)
    
    private let bottomLabel : UILabel = {
        let lb = UILabel()
        lb.font = .alegreyaSansRegular20()
        lb.textColor = .white
        lb.textAlignment = .left
        lb.text = "Already have an account?"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()

    private lazy var signInButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("Sign In", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .alegreyaSansBold20()
        btn.addTarget(self, action: #selector(signInTaped(_:)), for: .touchUpInside)
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
        hideKeyboardWhenTappedAround()
        setupTextFields()
        setupButtons()
        bindViewModel()
    }
    
    // MARK: - Buttons Methods

    @objc func signInTaped(_ sender: UIButton) {
        sender.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
            sender.alpha = 1
            self.navigationController?.pushViewController(SignInViewController(), animated: true)
        }
    }
    
    @objc func signInPressed(_ sender: UIButton) {
        if let email = emailField.text, let password = passwordField.text, let name = nameField.text {
            ViewModel.shared.registerUser(email: email, password: password, name: name)
        }
    }
    
    private func showAllert(titleText: String,messageText : String, succeed : Bool) {
        let alert = UIAlertController(title: titleText, message: messageText, preferredStyle: .alert)
        if succeed {
            let action = UIAlertAction(title: "Log In", style: .default) { (action) in
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(action)
        } else {
            let action = UIAlertAction(title: "Got it", style: .cancel)
            alert.addAction(action)
        }
        self.present(alert, animated: true)
    }
    
    // MARK: - SetupUI

    private func setupTextFields() {
        nameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
    }
    
    private func setupButtons() {
        signupButton.addTarget(self, action: #selector(signInPressed(_:)), for: .touchUpInside)
    }
    
    private func bindViewModel() {
        ViewModel.shared.registerStatus.bind { AccountRegistrationModel in
            DispatchQueue.main.async {
                self.showAllert(titleText: AccountRegistrationModel.title, messageText: AccountRegistrationModel.message, succeed: AccountRegistrationModel.succeed)
            }
        }

    }
    
    private func addSubviews() {
        view.addSubview(backgroundImage)
        view.addSubview(topStack)
        view.addSubview(fieldsStack)
        fieldsStack.addArrangedSubview(nameField)
        fieldsStack.addArrangedSubview(emailField)
        fieldsStack.addArrangedSubview(passwordField)
        view.addSubview(bottomButtonsStack)
        bottomButtonsStack.addArrangedSubview(signupButton)
        bottomButtonsStack.addArrangedSubview(lastLineStack)
        lastLineStack.addArrangedSubview(bottomLabel)
        lastLineStack.addArrangedSubview(signInButton)
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
            
            K.DeviceSizes.currentDeviceHeight <= 568 ?  fieldsStack.topAnchor.constraint(equalTo: topStack.bottomAnchor, constant: 5) : ((K.DeviceSizes.currentDeviceHeight <= 667) ?  fieldsStack.topAnchor.constraint(equalTo: topStack.bottomAnchor, constant: 15) :  fieldsStack.topAnchor.constraint(equalTo: topStack.bottomAnchor, constant: 25)),
            fieldsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            fieldsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        
            K.DeviceSizes.currentDeviceHeight <= 568 ? bottomButtonsStack.topAnchor.constraint(equalTo: fieldsStack.bottomAnchor, constant: 15) : ((K.DeviceSizes.currentDeviceHeight <= 667) ? bottomButtonsStack.topAnchor.constraint(equalTo: fieldsStack.bottomAnchor, constant: 35) : bottomButtonsStack.topAnchor.constraint(equalTo: fieldsStack.bottomAnchor, constant: 45)),
            bottomButtonsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomButtonsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

// MARK: - TextField Delegate

extension SignUpViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.endEditing(true)
        return true
    }
}
