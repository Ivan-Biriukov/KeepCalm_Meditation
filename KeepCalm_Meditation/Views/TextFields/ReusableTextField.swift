import UIKit

class ReusableTextField: UITextField {
    
    private var passwordHidden : Bool = true
    
    private lazy var showPasswordButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "eye.circle.fill"), for: .normal)
        btn.tintColor = .grayText()
        btn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 30).isActive = true
        btn.addTarget(self, action: #selector(showPasswordPressed(_:)), for: .touchUpInside)
        return btn
    }()

    enum FieldStyle : String {
        case email = "Email Address"
        case password = "Password"
        case userName = "Name"
    }

    private let style : FieldStyle
    
    init(style: FieldStyle) {
        self.style = style
        super.init(frame: .zero)
        configure()
        addBottomBorder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        self.attributedPlaceholder = NSAttributedString (
                    string: style.rawValue,
                    attributes: [NSAttributedString.Key.foregroundColor:
                                    UIColor.grayText() ?? UIColor.darkGray,
                                 NSAttributedString.Key.font: UIFont.alegreyaSansRegular18() ?? UIFont.systemFont(ofSize: 18)]
         )
        
        font = .alegreyaSansRegular18()
        textColor = .grayText()
        self.setLeftPaddingPoints(10)
        heightAnchor.constraint(equalToConstant: 60).isActive = true
        widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 70).isActive = true
        translatesAutoresizingMaskIntoConstraints = false
        returnKeyType = .done
        
        if style == .email {
            keyboardType = .emailAddress
            self.autocapitalizationType = .none
            clearButtonMode = .whileEditing
        } else if style == .password {
            keyboardType = .default
            isSecureTextEntry = true
            clearButtonMode = .never
            rightView = showPasswordButton
            rightViewMode = .always
            self.autocapitalizationType = .none
        } else {
            keyboardType = .default
            clearButtonMode = .whileEditing
            self.autocapitalizationType = .words
        }
    }
    
    
    @objc func showPasswordPressed(_ sender: UIButton) {
        passwordHidden = !passwordHidden
        isSecureTextEntry = !isSecureTextEntry
    
        passwordHidden ? showPasswordButton.setImage(UIImage(systemName: "eye.circle.fill"), for: .normal) : showPasswordButton.setImage(UIImage(systemName: "eye.slash.circle.fill"), for: .normal)
    }
}
