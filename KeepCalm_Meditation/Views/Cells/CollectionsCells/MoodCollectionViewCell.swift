import UIKit

class MoodCollectionViewCell: UICollectionViewCell {
    
    let itemImage : UIImageView = {
        let i = UIImageView()
        i.image = UIImage(named: K.MainVC.calm)
        i.contentMode = .scaleAspectFill
        i.frame.size = CGSize(width: 62, height: 65)
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    let itemLabel : UILabel = {
        let lb = UILabel()
        lb.font = .alegreyaSansRegular12()
        lb.textColor = .grayText()
        lb.textAlignment = .center
        lb.text = "Calm"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(itemImage)
        contentView.addSubview(itemLabel)
        contentView.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            itemImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            itemImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            itemLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            itemLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            itemLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
}
