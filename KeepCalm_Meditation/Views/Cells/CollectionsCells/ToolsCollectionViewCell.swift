import UIKit

class ToolsCollectionViewCell: UICollectionViewCell {
    
    var cellData : ToolsElementsModel? {
        didSet {
            backgroundImage.image = cellData?.backgroundImg
            toolIconImage.image = UIImage(systemName: cellData?.iconImgString ?? "person.crop.circle.badge.exclamationmark")
            toolNameLabel.text = cellData?.title
        }
    }
    
    private let backgroundImage : UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleToFill
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private let toolIconImage : UIImageView = {
        let img = UIImageView()
        img.tintColor = .black
        img.heightAnchor.constraint(equalToConstant: 20).isActive = true
        img.widthAnchor.constraint(equalToConstant: 20).isActive = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private let toolNameLabel : UILabel = {
        let lb = UILabel()
        lb.font = .alegreyaSansMedium18()
        lb.textColor = .white
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let contentStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .leading
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.addSubview(backgroundImage)
        contentView.layer.cornerRadius = 20
        contentView.addSubview(contentStack)
        contentStack.addArrangedSubview(toolIconImage)
        contentStack.addArrangedSubview(toolNameLabel)
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            contentStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            contentStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
        
        ])
    }
}
