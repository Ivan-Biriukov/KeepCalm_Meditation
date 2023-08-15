import UIKit

class MenuViewController: UIViewController {
    
    static var shared = MenuViewController()
        
    // MARK: - UI Elements
    
    private lazy var contentStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var firstLaneStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 75
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var titleLabel : UILabel = {
        let lb = UILabel()
        lb.font = .alegreyaMedium30()
        lb.textColor = .white
        lb.textAlignment = .right
        lb.text = "Profile Info"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var closeButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "xmark"), for: .normal)
        btn.tintColor = .white
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        btn.contentMode = .scaleToFill
        btn.addTarget(self, action: #selector(closePressed), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let userAvatarImg : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: K.userAvatarImg)
        img.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2).isActive = true
        img.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2).isActive = true
        img.layer.cornerRadius = UIScreen.main.bounds.width / 4
        img.layer.masksToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private lazy var photoEditActionsStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 15
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var choosePhotoButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "square.and.arrow.up.on.square"), for: .normal)
        btn.setTitle("  Upload Photo", for: .normal)
        btn.titleLabel?.font = .alegreyaSansBold16()
        btn.setTitleColor(.white, for: .normal)
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(choosePhotoTaped), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var takePhotoButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "camera.on.rectangle"), for: .normal)
        btn.setTitle("  Take Photo", for: .normal)
        btn.titleLabel?.font = .alegreyaSansBold16()
        btn.setTitleColor(.white, for: .normal)
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(takePhotoTaped), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var nameStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var nameLabel : UILabel = {
        let lb = UILabel()
        lb.font = .alegreyaSansBold20()
        lb.textAlignment = .center
        lb.textColor = .white
        lb.numberOfLines = 0
        lb.text = "Test Testovich"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var editNameButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "pencil"), for: .normal)
        btn.tintColor = .white
        btn.contentMode = .scaleAspectFill
        btn.widthAnchor.constraint(equalToConstant: 30).isActive = true
        btn.addTarget(self, action: #selector(editNameTaped), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var emailStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var emailLabel : UILabel = {
        let lb = UILabel()
        lb.font = .alegreyaSansBold20()
        lb.textAlignment = .center
        lb.textColor = .white
        lb.numberOfLines = 0
        lb.text = "123@dgddg.com"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var editEmailButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "pencil"), for: .normal)
        btn.tintColor = .white
        btn.contentMode = .scaleAspectFill
        btn.widthAnchor.constraint(equalToConstant: 30).isActive = true
        btn.addTarget(self, action: #selector(editEmailTaped), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var resetPasswordButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("Reset Password", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .alegreyaSansRegular25()
        btn.addTarget(self, action: #selector(resetPasswordTaped), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var logoutButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("Log out", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .alegreyaSansRegular25()
        btn.addTarget(self, action: #selector(logoutTaped), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    private let photoPikerView : UIImagePickerController = {
        let piker = UIImagePickerController()
        piker.allowsEditing = false
        return piker
    }()
    
    
    
    // MARK: - LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainBackgroundColor()
        addSubviews()
        setupConstraints()
        configurePiker()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavBar()
        hideTapBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showNavBar()
        showTapBar()
    }
    // MARK: -  Buttons Methods
    
    @objc func closePressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func choosePhotoTaped() {
        photoPikerView.sourceType = .photoLibrary
        present(photoPikerView, animated: true)
        
    }
    
    @objc func takePhotoTaped() {
        photoPikerView.sourceType = .camera
        present(photoPikerView, animated: true)
    }
    
    @objc func editNameTaped() {
        var textField1 = UITextField()
        let alert = UIAlertController(title: "Change User Name", message: nil, preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField1 = textField
            textField.placeholder = "Enter Your Name"
        }
        
        let confirmChangesAction = UIAlertAction(title: "Save & Close", style: .default) { _ in
            if let saveNewName = textField1.text {
                if saveNewName == "" || saveNewName == self.nameLabel.text {
                    textField1.placeholder = "Please enter New Value"
                    self.present(alert, animated: true, completion: nil)
                } else {
                    self.nameLabel.text = saveNewName
                }
            }
        }
        
        let exitAction = UIAlertAction(title: "Exit", style: .destructive)

        alert.addAction(confirmChangesAction)
        alert.addAction(exitAction)
        
        self.present(alert, animated: true)
    }
    
    @objc func editEmailTaped() {
        var textField1 = UITextField()
        
        let alert = UIAlertController(title: "Change E-mail adress", message: "Please enter new email adress here. It will be automaticaly change", preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField1 = textField
            textField.placeholder = "Enter email"
        }
        
        let confirmChangesAction = UIAlertAction(title: "Save & Close", style: .default) { _ in
            if let email = textField1.text {
                AuthViewModel.shared.changeEmail(newEmail: email)
            }
        }
        
        let exitAction = UIAlertAction(title: "Exit", style: .destructive)

        alert.addAction(confirmChangesAction)
        alert.addAction(exitAction)
        
        self.present(alert, animated: true)
    }
    
    @objc func resetPasswordTaped() {
        var newPasField = UITextField()
        
        let alert = UIAlertController(title: "Update Password", message: "Please fill up Your old password and the new one.", preferredStyle: .alert)
    
        alert.addTextField() { textField in
            newPasField = textField
            textField.placeholder = "new password"
        }
        
        let confirmAction = UIAlertAction(title: "Confirm Changes", style: .destructive) { action in
            AuthViewModel.shared.changePassword(newPassword: newPasField.text!)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel Changing", style: .default)
        
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
    
    @objc func logoutTaped() {
        AuthViewModel.shared.logOut()
        navigationController?.pushViewController(SignInViewController.shared, animated: true)
        print("Logged out")
    }
    
    // MARK: - Configure UI
    
    private func addSubviews() {
        view.addSubview(contentStack)
        contentStack.addArrangedSubview(firstLaneStack)
        firstLaneStack.addArrangedSubview(titleLabel)
        firstLaneStack.addArrangedSubview(closeButton)
        contentStack.addArrangedSubview(userAvatarImg)
        contentStack.addArrangedSubview(photoEditActionsStack)
        photoEditActionsStack.addArrangedSubview(choosePhotoButton)
        photoEditActionsStack.addArrangedSubview(takePhotoButton)
        contentStack.addArrangedSubview(nameStack)
        nameStack.addArrangedSubview(nameLabel)
        nameStack.addArrangedSubview(editNameButton)
        contentStack.addArrangedSubview(emailStack)
        emailStack.addArrangedSubview(emailLabel)
        emailStack.addArrangedSubview(editEmailButton)
        contentStack.addArrangedSubview(resetPasswordButton)
        contentStack.addArrangedSubview(logoutButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            contentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            firstLaneStack.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor)
        ])
    }
    
    private func configurePiker() {
        photoPikerView.delegate = self
    }
    
    private func bindViewModel() {
        AuthViewModel.shared.userAccountDataStatus.bind { UserData in
            DispatchQueue.main.async {
                self.emailLabel.text = UserData.userEmail
                self.nameLabel.text = UserData.userName
            }
        }
        
        AuthViewModel.shared.paswordChangeStatus.bind { string in
            DispatchQueue.main.async {
                if string == "" {
                    let resultAlert = UIAlertController(title: "Results", message: "Password has been succesfuly changed", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Close", style: .destructive)
                    resultAlert.addAction(action)
                    self.present(resultAlert, animated: true)
                } else {
                    let resultAlert = UIAlertController(title: "Results", message: string, preferredStyle: .alert)
                    let action = UIAlertAction(title: "Close", style: .destructive)
                    resultAlert.addAction(action)
                    self.present(resultAlert, animated: true)
                }
            }
        }
        
        AuthViewModel.shared.emailChangeStatus.bind { string in
            var newEmailString = ""
            
            if string == "" {
                AuthViewModel.shared.newEmailValue.bind { email in
                    newEmailString = email
                }
                DispatchQueue.main.async {
                    let resultAlert = UIAlertController(title: "Results", message: "Email has been succesfuly changed", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Close", style: .destructive)
                    resultAlert.addAction(action)
                    self.emailLabel.text = newEmailString
                    self.present(resultAlert, animated: true)
                }
            } else {
                DispatchQueue.main.async {
                    let resultAlert = UIAlertController(title: "Error", message: string, preferredStyle: .alert)
                    let action = UIAlertAction(title: "Close", style: .destructive)
                    resultAlert.addAction(action)
                    self.present(resultAlert, animated: true)
                }
            }
        }
    }
}

// MARK: - UIPickerDelegate

extension MenuViewController : UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let tempImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        let imageURL = info[UIImagePickerController.InfoKey.imageURL] as! NSURL
        =
        userAvatarImg.image  = tempImage
        self.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }}
