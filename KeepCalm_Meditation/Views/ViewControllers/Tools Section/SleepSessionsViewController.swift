import UIKit

class SleepSessionsViewController: UIViewController {
    
    private var contentSize : CGSize {
        CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    // MARK: - UI Elements
    
    private lazy var scrollView : UIScrollView = {
        let s = UIScrollView()
        s.contentSize = contentSize
        s.isScrollEnabled = false
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    private lazy var contentView : UIView = {
        let content = UIView()
        content.frame.size = contentSize
        return content
    }()
    
    private let contentStackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let sleepTimerTitleLabel: UILabel = {
        let lb = UILabel()
        lb.font = .alegreyaMedium30()
        lb.textColor = .white
        lb.textAlignment = .left
        lb.text = "Sleep Timer"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var sleepTimeLabelsStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var hoursLabel : UILabel = {
        let lb = UILabel()
        lb.font = .alegreyaMedium35()
        lb.textColor = .white
        lb.textAlignment = .center
        lb.text = "00"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var minutsLabel : UILabel = {
        let lb = UILabel()
        lb.font = .alegreyaMedium35()
        lb.textColor = .white
        lb.textAlignment = .center
        lb.text = "00"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var secondsLabel : UILabel = {
        let lb = UILabel()
        lb.font = .alegreyaMedium35()
        lb.textColor = .white
        lb.textAlignment = .center
        lb.text = "00"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var firstSeparate : UILabel = {
        let lb = UILabel()
        lb.font = .alegreyaMedium35()
        lb.textColor = .white
        lb.textAlignment = .center
        lb.text = ":"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var secondSeparate : UILabel = {
        let lb = UILabel()
        lb.font = .alegreyaMedium35()
        lb.textColor = .white
        lb.textAlignment = .center
        lb.text = ":"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var sleepSessionsActionsStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var goToSleepButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("Go to Sleep", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .buttonBackground()
        btn.layer.cornerRadius = 10
        btn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btn.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3).isActive = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var awakeButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("Awake", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .buttonBackground()
        btn.layer.cornerRadius = 10
        btn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btn.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3).isActive = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let sleepSessionTitleLabel : UILabel = {
        let lb = UILabel()
        lb.font = .alegreyaMedium30()
        lb.textColor = .white
        lb.textAlignment = .left
        lb.text = "Last Sleep Info"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let sleepSessionQuolityCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        if K.DeviceSizes.currentDeviceHeight <= 667 {
            layout.itemSize = CGSize(width: (UIScreen.main.bounds.width / 3), height: (UIScreen.main.bounds.height / 3.5))
        } else {
            layout.itemSize = CGSize(width: (UIScreen.main.bounds.width / 3.5), height: (UIScreen.main.bounds.height / 5))
        }
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40).isActive = true
        c.heightAnchor.constraint(equalToConstant: K.DeviceSizes.currentDeviceHeight / 3).isActive = true
        c.indicatorStyle = .white
        c.translatesAutoresizingMaskIntoConstraints = false
        c.backgroundColor = .clear
        return c
    }()
    
    private let bedTimeTitleLabel : UILabel = {
        let lb = UILabel()
        lb.font = .alegreyaMedium30()
        lb.textColor = .white
        lb.textAlignment = .left
        lb.text = "Bedtime"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    // MARK: - LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainBackgroundColor()
        addSubviews()
        setupConstraints()
        configureNavBar()
        configureCollectionView()
    }
    
    // MARK: - Buttons Methods
    
    
    // MARK: - Configure UI
    
    private func configureCollectionView() {
        sleepSessionQuolityCollection.delegate = self
        sleepSessionQuolityCollection.dataSource = self
        sleepSessionQuolityCollection.register(SleepQuolityCollectionViewCell.self, forCellWithReuseIdentifier: "SleepCell")
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(sleepTimerTitleLabel)
        contentStackView.addArrangedSubview(sleepTimeLabelsStack)
        sleepTimeLabelsStack.addArrangedSubview(hoursLabel)
        sleepTimeLabelsStack.addArrangedSubview(firstSeparate)
        sleepTimeLabelsStack.addArrangedSubview(minutsLabel)
        sleepTimeLabelsStack.addArrangedSubview(secondSeparate)
        sleepTimeLabelsStack.addArrangedSubview(secondsLabel)
        contentStackView.addArrangedSubview(sleepSessionsActionsStack)
        sleepSessionsActionsStack.addArrangedSubview(goToSleepButton)
        sleepSessionsActionsStack.addArrangedSubview(awakeButton)
        contentStackView.addArrangedSubview(sleepSessionTitleLabel)
        contentStackView.addArrangedSubview(sleepSessionQuolityCollection)
        contentStackView.addArrangedSubview(bedTimeTitleLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            contentStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            contentStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            
            sleepTimerTitleLabel.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor),
            sleepSessionTitleLabel.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor),
            bedTimeTitleLabel.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor),
        ])
    }
}

// MARK: - CollectionView Delegate & DataSource

extension SleepSessionsViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SleepCell", for: indexPath) as! SleepQuolityCollectionViewCell
        
        return cell
    }
    
    
}
