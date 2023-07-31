import UIKit

protocol PostCollectionViewCellDelegate {
    func playButtonPressed()
}

class PostCollectionViewCell: UICollectionViewCell {
    
    private var delegate : PostCollectionViewCellDelegate?
    
    private let titleLabel : UILabel = {
        let lb = UILabel()
        lb.font = .alegreyaMedium25()
        lb.textColor = .black
        lb.textAlignment = .left
        lb.text = "Meditation 101"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let discLabel : UILabel = {
        let lb = UILabel()
        lb.font = .alegreyaSansMedium15()
        lb.textColor = .black
        lb.textAlignment = .left
        lb.numberOfLines = 0
        lb.text = "Techniques, Benefits, and a Beginner’s How-To"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var watchButton : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .mainBackgroundColor()
        btn.tintColor = .white
        btn.layer.cornerRadius = 10
        btn.setTitle("watch now", for: .normal)
        btn.titleLabel?.font = .alegreyaSansMedium15()
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(playButtonPressed(_:)), for: .touchUpInside)
        btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btn.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2.5).isActive = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let leftStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .leading
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let image : UIImageView = {
        let im = UIImageView()
        im.contentMode = .scaleAspectFit
        im.image = UIImage(named: K.MainVC.cardioImg)
        im.translatesAutoresizingMaskIntoConstraints = false
        return im
    }()
    
    private let mainStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        watchButton.addRightIcon(image: UIImage(systemName: "play.circle.fill")!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 20
        contentView.addSubview(mainStack)
        mainStack.addArrangedSubview(leftStack)
        leftStack.addArrangedSubview(titleLabel)
        leftStack.addArrangedSubview(discLabel)
        leftStack.addArrangedSubview(watchButton)
        mainStack.addArrangedSubview(image)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
    
    
    @objc func playButtonPressed(_ sender: UIButton) {
        sender.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.alpha = 1
            self.delegate?.playButtonPressed()
        }
    }
    
    
}
