import UIKit

class MainViewController: UIViewController {
    
    var userName : String = "Test"
    
    private var contentSize : CGSize {
        CGSize(width: view.frame.width, height: view.frame.height + 300)
    }
    
    // MARK: - UI Elements
    
    private lazy var scrollView : UIScrollView = {
        let s = UIScrollView()
        s.contentSize = contentSize
        s.frame = view.bounds
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
        stack.alignment = .leading
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let mainLabel : UILabel = {
        let l = UILabel()
        l.font = .alegreyaMedium30()
        l.textColor = .white
        l.textAlignment = .left
        l.text = "Welcome back, Jhon!"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let discriptionLabel : UILabel = {
        let l = UILabel()
        l.font = .alegreyaSansRegular22()
        l.textColor = .grayText()
        l.textAlignment = .left
        l.text = "How are you feeling today ?"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let labelStack : UIStackView = {
        let s = UIStackView()
        s.axis = .vertical
        s.distribution = .fill
        s.spacing = 5
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    private let moodCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 65, height: 90)
        layout.minimumLineSpacing = 26
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.heightAnchor.constraint(equalToConstant: 120).isActive = true
        c.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 50).isActive = true
        c.translatesAutoresizingMaskIntoConstraints = false
        c.backgroundColor = .clear
        return c
    }()
    
    private lazy var postsCollections : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 60, height: 170)
        layout.minimumLineSpacing = 26
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 2).isActive = true
        c.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40).isActive = true
        c.translatesAutoresizingMaskIntoConstraints = false
        c.backgroundColor = .clear
        return c
    }()
    
    // MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainBackgroundColor()
        addSubviews()
        configureNavBar()
        setupDelegates()
        setupConstraints()
        setupCollectiuons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Buttons Methods
    
    
    // MARK: - Configure UI
    
    private func setupDelegates() {
        scrollView.delegate = self
        moodCollection.delegate = self
        moodCollection.dataSource = self
        postsCollections.delegate = self
        postsCollections.dataSource = self
    }
    
    private func setupCollectiuons() {
        moodCollection.register(MoodCollectionViewCell.self, forCellWithReuseIdentifier: "MoodCell")
        postsCollections.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: "PostCell")
    }

    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(labelStack)
        labelStack.addArrangedSubview(mainLabel)
        labelStack.addArrangedSubview(discriptionLabel)
        contentStackView.addArrangedSubview(moodCollection)
        contentStackView.addArrangedSubview(postsCollections)
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            contentStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            contentStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            
        ])
    }
}

// MARK: - ScrollView Delegte

extension MainViewController : UIScrollViewDelegate {
    
}

// MARK: - CollectionView Delegate & DataSource

extension MainViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == moodCollection {
            return 4
        } else {
            return 6
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == moodCollection {
            let cell = moodCollection.dequeueReusableCell(withReuseIdentifier: "MoodCell", for: indexPath) as! MoodCollectionViewCell
            return cell
        } else {
            let cell = postsCollections.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as! PostCollectionViewCell
            return cell
        }
    }
    
    
}
