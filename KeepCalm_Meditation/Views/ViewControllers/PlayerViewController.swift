import UIKit

class PlayerViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private let contentStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let songImage : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: K.MusicPlayVc.soundImg)
        view.contentMode = .scaleToFill
        view.heightAnchor.constraint(equalToConstant: 250).isActive = true
        view.widthAnchor.constraint(equalToConstant: 250).isActive = true
        view.layer.cornerRadius = 125
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let songNameLabel : UILabel = {
        let lb = UILabel()
        lb.font = .alegreyaMedium35()
        lb.textAlignment = .center
        lb.textColor = .white
        lb.text = "Painting Forest"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let songAuthorLabel : UILabel = {
        let lb = UILabel()
        lb.font = .alegreyaSansRegular25()
        lb.textAlignment = .center
        lb.textColor = .white
        lb.text = "By: Painting with Passion"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let titleStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainBackgroundColor()
        addSubviews()
        setupUI()
    }
    
    
    // MARK: - Buttons Methods
    
    // MARK: - Configure UI
    
    private func addSubviews() {
        view.addSubview(contentStack)
        contentStack.addArrangedSubview(songImage)
        contentStack.addArrangedSubview(titleStack)
        titleStack.addArrangedSubview(songNameLabel)
        titleStack.addArrangedSubview(songAuthorLabel)
    }
    
    private func setupUI() {
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            contentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            contentStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            contentStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        
        ])
    }
    
}
