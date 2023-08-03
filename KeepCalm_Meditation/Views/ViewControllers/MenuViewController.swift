import UIKit
import BonsaiController

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
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var titleLabel : UILabel = {
        let lb = UILabel()
        lb.font = .alegreyaMedium30()
        lb.textColor = .white
        lb.textAlignment = .center
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
        lb.font = .alegreyaSansBold16()
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
    
    private lazy var recoverPasswordButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("Recover Password", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .alegreyaSansRegular14()
        btn.addTarget(self, action: #selector(recoverTaped), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var logoutButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("Log out", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .alegreyaSansRegular14()
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
    }
    
    // MARK: -  Buttons Methods
    
    @objc func closePressed() {
        self.dismiss(animated: true)
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
        let charset = CharacterSet(charactersIn: "@.")
        
        let alert = UIAlertController(title: "Change E-mail adress", message: "Please enter new email adress here. It will be automaticaly change", preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField1 = textField
            textField.placeholder = "Enter email"
        }
        
        let confirmChangesAction = UIAlertAction(title: "Save & Close", style: .default) { _ in
            if let saveNewName = textField1.text {
                if saveNewName == "" || saveNewName == self.emailLabel.text || saveNewName.rangeOfCharacter(from: charset) == nil {
                    textField1.placeholder = "Invalid Email adress"
                    self.present(alert, animated: true, completion: nil)
                    textField1.text = ""
                } else {
                    self.emailLabel.text = saveNewName
                }
            }
        }
        
        let exitAction = UIAlertAction(title: "Exit", style: .destructive)

        alert.addAction(confirmChangesAction)
        alert.addAction(exitAction)
        
        self.present(alert, animated: true)
        
    }
    
    @objc func recoverTaped() {}
    
    @objc func logoutTaped() {}
    
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
        contentStack.addArrangedSubview(recoverPasswordButton)
        contentStack.addArrangedSubview(logoutButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            contentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func configurePiker() {
        photoPikerView.delegate = self
    }
}

// MARK: - BonsaiController Extension

extension MenuViewController: BonsaiControllerDelegate {
    
    // return the frame of your Bonsai View Controller
    func frameOfPresentedView(in containerViewFrame: CGRect) -> CGRect {
        
        switch K.DeviceSizes.currentDeviceHeight {
        case 0...568:
            return CGRect(origin: CGPoint(x: 0, y: 60), size: CGSize(width: (containerViewFrame.width - containerViewFrame.width / 4), height: containerViewFrame.height - 65))
        case 569...667:
            return CGRect(origin: CGPoint(x: 0, y: 70), size: CGSize(width: (containerViewFrame.width - containerViewFrame.width / 4), height: containerViewFrame.height - 75))
        default:
            return CGRect(origin: CGPoint(x: 0, y: 100), size: CGSize(width: (containerViewFrame.width - containerViewFrame.width / 4.7), height: containerViewFrame.height - 105))
        }
    }
    
    // return a Bonsai Controller with SlideIn or Bubble transition animator
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {

        return BonsaiController(fromDirection: .left, blurEffectStyle: .systemMaterialDark, presentedViewController: presented, delegate: self)
        
    }
}

// MARK: - UIPickerDelegate

extension MenuViewController : UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let tempImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        userAvatarImg.image  = tempImage
        self.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }}
