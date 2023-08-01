import UIKit

class ToolsRootViewController: UIViewController {
    
    // MARK: - Data
    private let elemetnsDataArray : [ToolsElementsModel] = [
        .init(backgroundImg: UIImage(named: K.ToolsVC.firstImage), iconImgString: "arrow.up.message.fill", title: "Mood Booster"),
        .init(backgroundImg: UIImage(named: K.ToolsVC.secongImage), iconImgString: "waveform.path.ecg", title: "Meditation"),
        .init(backgroundImg: UIImage(named: K.ToolsVC.thirdImage), iconImgString: "powersleep", title: "Sleep Session"),
        .init(backgroundImg: UIImage(named: K.ToolsVC.fourthImage), iconImgString: "arrow.up.heart.fill", title: "Stats")
    ]
    
    
    // MARK: - UI Elements
    
    private let titleLabel : UILabel = {
        let lb = UILabel()
        lb.font = .alegreyaMedium35()
        lb.textColor = .white
        lb.textAlignment = .left
        lb.text = "Tools"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let toolsCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        if K.DeviceSizes.currentDeviceHeight <= 667 {
            layout.itemSize = CGSize(width: (UIScreen.main.bounds.width / 2.5), height: (UIScreen.main.bounds.height / 4.5))
        } else {
            layout.itemSize = CGSize(width: (UIScreen.main.bounds.width / 2.5), height: (UIScreen.main.bounds.height / 5.5))
        }
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.translatesAutoresizingMaskIntoConstraints = false
        c.backgroundColor = .clear
        return c
    }()
    
    
    
    // MARK: - LifeCYcleMethods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainBackgroundColor()
        configureNavBar()
        addSubviews()
        configureUI()
        configureCollection()
    }
    
    // MARK: - Configure UI
    
    private func configureCollection() {
        toolsCollection.delegate = self
        toolsCollection.dataSource = self
        toolsCollection.register(ToolsCollectionViewCell.self, forCellWithReuseIdentifier: "ToolsCell")
    }

    private func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(toolsCollection)
    }
    
    private func configureUI() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 125),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            
            toolsCollection.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            toolsCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            toolsCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            toolsCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80)
        ])
    }
}

// MARK: - CollectionView Delegate & DataSource

extension ToolsRootViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return elemetnsDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ToolsCell", for: indexPath) as! ToolsCollectionViewCell
        
        cell.cellData = elemetnsDataArray[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 1:
            self.navigationController?.pushViewController(MeditationViewController(), animated: true)
        case 2:
            self.navigationController?.pushViewController(SleepSessionsViewController(), animated: true)
        default:
            print("Not Meditation")
        }
    }
}
