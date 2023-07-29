import UIKit

class ReusableButton: UIButton {

    enum ButtonStyle : String {
        case loginEmail = "Login With Email"
        case login = "LOGIN"
        case signUp = "SIGNUP"
        case startNow = "Start Now"
    }
    
    private let style : ButtonStyle
    
    init(style: ButtonStyle) {
        self.style = style
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .buttonBackground()
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .alegreyaSansMedium25()
        layer.cornerRadius = 10
        setTitle(style.rawValue, for: .normal)
        heightAnchor.constraint(equalToConstant: 61).isActive = true
        addTarget(self, action: #selector(reusableButtonTapped(_:)), for: .touchUpInside)
        
        if style != .startNow {
            widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 54).isActive = true
        } else {
            widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 150).isActive = true
        }
    }
    
    @objc func reusableButtonTapped(_ sender: UIButton) {
        self.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.alpha = 1
        }
    }
}
