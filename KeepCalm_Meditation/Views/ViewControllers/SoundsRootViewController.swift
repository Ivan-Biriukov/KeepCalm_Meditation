import UIKit

class SoundsRootViewController: UIViewController {

    // MARK: - UI Elements
    
    private let titleBubleView : UIView = {
        let v = UIView()
        v.layer.cornerRadius = 20
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let bubleViewImage : UIImageView = {
        let img = UIImageView(image: UIImage(named: K.MusicPlayVc.squareImg))
        img.contentMode = .scaleToFill
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private let bubleViewContentStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let bubleViewTitleLabel : UILabel = {
        let lb = UILabel()
        lb.font = .alegreyaMedium27()
        lb.textColor = .white
        lb.textAlignment = .left
        lb.text = "Relax Sounds"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let bubleViewDiscLabel : UILabel = {
        let lb = UILabel()
        lb.font = .alegreyaSansMedium15()
        lb.textColor = .white
        lb.textAlignment = .left
        lb.text = "Sometimes the most productive thing you can do is relax."
        lb.numberOfLines = 0
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var bublePlayButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("play now", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .white
        btn.tintColor = .black
        btn.layer.cornerRadius = 10
        btn.titleLabel?.font = .alegreyaSansMedium15()
        btn.addRightIcon(image: UIImage(systemName: "play.circle.fill")!)
        btn.heightAnchor.constraint(equalToConstant: 39).isActive = true
        btn.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3).isActive = true
        btn.addTarget(self, action: #selector(playNowPressed(_:)), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var songsTableView = UITableView()
    
    // MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainBackgroundColor()
        addSubviews()
        setupConstraints()
        configureNavBar()
        configureTableView()
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
    
    @objc func playNowPressed(_ sender: UIButton) {
        sender.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.alpha = 1
        }
    }

    // MARK: - Configure UI
    
    private func configureTableView() {
        songsTableView.translatesAutoresizingMaskIntoConstraints = false
        songsTableView.delegate = self
        songsTableView.dataSource = self
        songsTableView.register(SongsTableViewCell.self, forCellReuseIdentifier: "SongsCell")
        songsTableView.separatorStyle = .none
        songsTableView.backgroundColor = .clear
        songsTableView.indicatorStyle = .white
    }
    
    private func addSubviews() {
        view.addSubview(titleBubleView)
        titleBubleView.addSubview(bubleViewImage)
        titleBubleView.addSubview(bubleViewContentStack)
        bubleViewContentStack.addArrangedSubview(bubleViewTitleLabel)
        bubleViewContentStack.addArrangedSubview(bubleViewDiscLabel)
        bubleViewContentStack.addArrangedSubview(bublePlayButton)
        view.addSubview(songsTableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            K.DeviceSizes.currentDeviceHeight <= 568 ?             titleBubleView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80) : ((  K.DeviceSizes.currentDeviceHeight <= 667) ? titleBubleView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100) : titleBubleView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120)),
            titleBubleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleBubleView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            K.DeviceSizes.currentDeviceHeight <= 667 ?         titleBubleView.heightAnchor.constraint(equalToConstant: K.DeviceSizes.currentDeviceHeight / 3) : titleBubleView.heightAnchor.constraint(equalToConstant: K.DeviceSizes.currentDeviceHeight / 4),
            
            bubleViewImage.topAnchor.constraint(equalTo: titleBubleView.topAnchor),
            bubleViewImage.leadingAnchor.constraint(equalTo: titleBubleView.leadingAnchor),
            bubleViewImage.trailingAnchor.constraint(equalTo: titleBubleView.trailingAnchor),
            bubleViewImage.bottomAnchor.constraint(equalTo: titleBubleView.bottomAnchor),
            
            bubleViewContentStack.topAnchor.constraint(equalTo: titleBubleView.topAnchor, constant: 20),
            bubleViewContentStack.leadingAnchor.constraint(equalTo: titleBubleView.leadingAnchor, constant: 37),
            bubleViewContentStack.trailingAnchor.constraint(equalTo: titleBubleView.trailingAnchor, constant: -80),
            bubleViewContentStack.bottomAnchor.constraint(equalTo: titleBubleView.bottomAnchor, constant: -10),
            
            songsTableView.topAnchor.constraint(equalTo: titleBubleView.bottomAnchor, constant: 30),
            songsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            songsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            K.DeviceSizes.currentDeviceHeight <= 568 ? songsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50) : ((K.DeviceSizes.currentDeviceHeight <= 667) ? songsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60) : songsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80))
            
        ])
    }
}

// MARK: - TableView Delegate & DataSource

extension SoundsRootViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongsCell", for: indexPath) as! SongsTableViewCell
        return cell
    }
}
