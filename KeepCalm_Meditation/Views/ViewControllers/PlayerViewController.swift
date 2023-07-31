import UIKit

class PlayerViewController: UIViewController, PlayerButtonsDelegate {
    
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
    
    private let songProgress : UIProgressView = {
        let pg = UIProgressView()
        pg.progress = 0.1
        pg.progressViewStyle = .bar
        pg.trackTintColor = .lightGray
        pg.progressTintColor = .darkGray
        pg.heightAnchor.constraint(equalToConstant: 5).isActive = true
        pg.translatesAutoresizingMaskIntoConstraints = false
        return pg
    }()
    
    private let actionsButtonsStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let shuffleButton = PlayerButtons(style: .shuffle)
    private let backwardButton = PlayerButtons(style: .back)
    private let playPauseButton = PlayerButtons(style: .play_pause)
    private let forwardButton = PlayerButtons(style: .forward)
    private let reverseButton = PlayerButtons(style: .reverse)
    
    // MARK: - LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainBackgroundColor()
        addSubviews()
        setupUI()
        addButtonsTarget()
    }
    
    
    // MARK: - Buttons Methods
    
    @objc func playerButtonPressed(_ sender: UIButton) {
    }
    
    
    // MARK: - Configure UI
    
    private func addButtonsTarget() {
        let buttonArray = [shuffleButton, backwardButton, playPauseButton, forwardButton, reverseButton]
        for button in buttonArray {
            button.addTarget(self, action: #selector(playerButtonPressed(_:)), for: .touchUpInside)
        }
    }
    
    private func addSubviews() {
        view.addSubview(contentStack)
        contentStack.addArrangedSubview(songImage)
        contentStack.addArrangedSubview(titleStack)
        titleStack.addArrangedSubview(songNameLabel)
        titleStack.addArrangedSubview(songAuthorLabel)
        contentStack.addArrangedSubview(songProgress)
        contentStack.addArrangedSubview(actionsButtonsStack)
        actionsButtonsStack.addArrangedSubview(shuffleButton)
        actionsButtonsStack.addArrangedSubview(backwardButton)
        actionsButtonsStack.addArrangedSubview(playPauseButton)
        actionsButtonsStack.addArrangedSubview(forwardButton)
        actionsButtonsStack.addArrangedSubview(reverseButton)
    }
    
    private func setupUI() {
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            contentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            contentStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            K.DeviceSizes.currentDeviceHeight <= 568 ?  contentStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30) : ((K.DeviceSizes.currentDeviceHeight <= 667) ?  contentStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40) :  contentStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60)),
                        
            songProgress.leadingAnchor.constraint(equalTo: contentStack.leadingAnchor, constant: 20),
            songProgress.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor, constant: -20),
            
            actionsButtonsStack.leadingAnchor.constraint(equalTo: contentStack.leadingAnchor),
            actionsButtonsStack.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor),
        ])
    }
}
