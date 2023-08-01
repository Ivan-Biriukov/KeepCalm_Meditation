import UIKit

class MeditationViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private let contentStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 15
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var mainTitle : UILabel = {
        let lb = UILabel()
        lb.font = .alegreyaMedium35()
        lb.textColor = .white
        lb.textAlignment = .center
        lb.text = "Meditation"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var noticeTitle : UILabel = {
        let lb = UILabel()
        lb.font = .alegreyaSansRegular20()
        lb.textColor = .grayText()
        lb.textAlignment = .center
        lb.numberOfLines = 0
        lb.text = "Guided by a short introductory course, start trying meditation."
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var meditationImage : UIImageView = {
        let img = UIImageView(image: UIImage(named: K.meditationIcon))
        img.contentMode = .scaleToFill
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private lazy var minutsLabel : UILabel = {
        let lb = UILabel()
        lb.font = .alegreyaSansRegular38()
        lb.textColor = .white
        lb.textAlignment = .center
        lb.text = "00"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var separateLabel : UILabel = {
        let lb = UILabel()
        lb.font = .alegreyaSansRegular38()
        lb.textColor = .white
        lb.textAlignment = .center
        lb.text = ":"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var secondsLabel : UILabel = {
        let lb = UILabel()
        lb.font = .alegreyaSansRegular38()
        lb.textColor = .white
        lb.textAlignment = .center
        lb.text = "00"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var timeStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var startTimerButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "play.fill"), for: .normal)
        btn.tintColor = .white
        btn.contentMode = .scaleToFill
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        btn.addTarget(self, action: #selector(startTimerPressed(_:)), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var pauseTimerButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        btn.tintColor = .white
        btn.contentMode = .scaleToFill
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        btn.addTarget(self, action: #selector(pauseTimerPressed(_:)), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var stopTimerButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "stop.fill"), for: .normal)
        btn.tintColor = .white
        btn.contentMode = .scaleToFill
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        btn.addTarget(self, action: #selector(stopButtonPressed(_:)), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var buttonsStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    // MARK: - LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainBackgroundColor()
        configureNavBar()
        addSubviews()
        setupConstraints()
    }
    
    
    // MARK: - Buttons Methods
    
    @objc func startTimerPressed(_ sender: UIButton) {
        
    }
    
    @objc func pauseTimerPressed(_ sender: UIButton) {
        
    }
    
    @objc func stopButtonPressed(_ sender: UIButton) {
        
    }
    
    // MARK: - Configure UI
    
    private func addSubviews() {
        view.addSubview(contentStack)
        contentStack.addArrangedSubview(mainTitle)
        contentStack.addArrangedSubview(noticeTitle)
        contentStack.addArrangedSubview(meditationImage)
        contentStack.addArrangedSubview(timeStack)
        timeStack.addArrangedSubview(minutsLabel)
        timeStack.addArrangedSubview(separateLabel)
        timeStack.addArrangedSubview(secondsLabel)
        contentStack.addArrangedSubview(buttonsStack)
        buttonsStack.addArrangedSubview(startTimerButton)
        buttonsStack.addArrangedSubview(pauseTimerButton)
        buttonsStack.addArrangedSubview(stopTimerButton)
    }
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            K.DeviceSizes.currentDeviceHeight <= 568 ? contentStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 70) : ((K.DeviceSizes.currentDeviceHeight <= 667) ? contentStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 80) : contentStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)),
            contentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 41),
            contentStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -41),
            K.DeviceSizes.currentDeviceHeight <= 568 ? contentStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60) : ((K.DeviceSizes.currentDeviceHeight <= 667) ? contentStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80) : contentStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200)),
        ])
    }
}
