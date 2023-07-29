import UIKit

class LoginTopStack: UIStackView {

    enum StackStyle : String {
        case signIn = "Sign In"
        case signUp = "Sign Up"
    }
    
    let style : StackStyle
    
    private let logoIcon : UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: K.mainLogoImage)
        logo.contentMode = .scaleAspectFill
        logo.heightAnchor.constraint(equalToConstant: 100).isActive = true
        logo.widthAnchor.constraint(equalToConstant: 70).isActive = true
        return logo
    }()
    
    private let mainTitleLabel : UILabel = {
        let lb = UILabel()
        lb.font = .alegreyaMedium30()
        lb.textColor = .white
        lb.textAlignment = .left
        return lb
    }()
    
    private let discriptionLabel : UILabel = {
        let lb = UILabel()
        lb.font = .alegreyaSansRegular22()
        lb.textColor = .grayText()
        lb.numberOfLines = 0
        lb.textAlignment = .left
        return lb
    }()
    
    init(style: StackStyle) {
        self.style = style
        super.init(frame: .zero)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addArrangedSubview(logoIcon)
        addArrangedSubview(mainTitleLabel)
        addArrangedSubview(discriptionLabel)
        axis = .vertical
        distribution = .equalSpacing
        spacing = 8
        alignment = .leading
        translatesAutoresizingMaskIntoConstraints = false
        mainTitleLabel.text = style.rawValue
        
        switch style {
        case .signIn:
            discriptionLabel.text = "Sign in now to acces your excercises and saved music."
        case .signUp:
            discriptionLabel.text = "Sign up now for free and start meditating, and explore Medic."
        }
    }
}
