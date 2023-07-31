import UIKit

protocol PlayerButtonsDelegate {
    func playerButtonPressed(_ sender: UIButton)
}

class PlayerButtons: UIButton {

    enum ButtonType : Int {
        case shuffle = 0
        case back = 1
        case play_pause = 2
        case forward = 3
        case reverse = 4
    }
    
    private let style : ButtonType
    var delegate : PlayerButtonsDelegate?
    private var isPaused : Bool = false
    private var shuffleActive : Bool = false
    private var repeatActive : Bool = false

    init(style: ButtonType) {
        self.style = style
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addTarget(self, action: #selector(playerButtonPressed(_:)), for: .touchUpInside)
        tag = style.rawValue
        tintColor = .white
        backgroundColor = .clear
        contentMode = .scaleToFill
        translatesAutoresizingMaskIntoConstraints = false
        
        switch style {
        case .shuffle:
            setImage(UIImage(systemName: "shuffle"), for: .normal)
            heightAnchor.constraint(equalToConstant: 20).isActive = true
            widthAnchor.constraint(equalToConstant: 20).isActive = true
        case .back:
            setImage(UIImage(systemName: "backward.fill"), for: .normal)
            heightAnchor.constraint(equalToConstant: 20).isActive = true
            widthAnchor.constraint(equalToConstant: 20).isActive = true
        case .play_pause:
            backgroundColor = .white
            tintColor = .mainBackgroundColor()
            setImage(UIImage(systemName: "play.fill"), for: .normal)
            heightAnchor.constraint(equalToConstant: 75).isActive = true
            widthAnchor.constraint(equalToConstant: 75).isActive = true
            layer.cornerRadius = 37.5
        case .forward:
            setImage(UIImage(systemName: "forward.fill"), for: .normal)
            heightAnchor.constraint(equalToConstant: 20).isActive = true
            widthAnchor.constraint(equalToConstant: 20).isActive = true
        case .reverse:
            setImage(UIImage(systemName: "repeat"), for: .normal)
            heightAnchor.constraint(equalToConstant: 20).isActive = true
            widthAnchor.constraint(equalToConstant: 20).isActive = true
        }
    }
    
    @objc func playerButtonPressed(_ sender: UIButton) {
        sender.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.alpha = 1
            self.delegate?.playerButtonPressed(sender)
        }
        if sender.tag == 2 {
            self.isPaused = !self.isPaused
            if self.isPaused {
                sender.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            } else {
                sender.setImage(UIImage(systemName: "play.fill"), for: .normal)
            }
        } else if sender.tag == 0 {
            self.shuffleActive = !self.shuffleActive
            if self.shuffleActive {
                sender.tintColor = .darkGray
            } else {
                sender.tintColor = .white
            }
        } else if sender.tag == 4 {
            self.repeatActive = !self.repeatActive
            if self.repeatActive {
                sender.tintColor = .darkGray
            } else {
                sender.tintColor = .white
            }
        }
    }
}
