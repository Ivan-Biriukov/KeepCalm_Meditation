import UIKit

class SleepQuolityCollectionViewCell: UICollectionViewCell {
    
    var cellData : SleepInfoCollectionViewDataModel?  {
        didSet {
            self.cellIconImage.image = UIImage(systemName: cellData!.imageStringSystemName)
            self.discLabel.text = cellData?.valueLabelText
            self.titleLabel.text = cellData?.titleLabelText
        }
    }
        
    private lazy var contentStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 15
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let cellIconImage : UIImageView = {
        let img = UIImageView()
        img.heightAnchor.constraint(equalToConstant: 30).isActive = true
        img.widthAnchor.constraint(equalToConstant: 30).isActive = true
        img.contentMode = .scaleAspectFill
        img.tintColor = .white
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    lazy var discLabel : UILabel = {
        let lb = UILabel()
        lb.font = .alegreyaSansMedium18()
        lb.textColor = .white
        lb.textAlignment = .center
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    lazy var titleLabel : UILabel = {
        let lb = UILabel()
        lb.font = .alegreyaSansRegular12()
        lb.textColor = .white
        lb.textAlignment = .center
        lb.numberOfLines = 0
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        addSleepQuolityCellData(iconImage: UIImage(systemName: "bolt")!, discText: "Test", titleText: "Test")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.backgroundColor = UIColor(red: 105/256, green: 176/256, blue: 156/256, alpha: 1)
        contentView.layer.cornerRadius = 20
        
        contentView.addSubview(contentStack)
        contentStack.addArrangedSubview(cellIconImage)
        contentStack.addArrangedSubview(discLabel)
        contentStack.addArrangedSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            contentStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            contentStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            contentStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
    }
    
    private func addSleepQuolityCellData(iconImage : UIImage, discText: String, titleText: String) {
        self.cellIconImage.image = iconImage
        self.discLabel.text = discText
        self.titleLabel.text = titleText
    }
    
}
