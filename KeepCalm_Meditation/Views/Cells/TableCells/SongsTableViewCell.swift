import UIKit

class SongsTableViewCell: UITableViewCell {
    
    var cellData : MusicDataModel? {
        didSet {
            self.songNameLabel.text = cellData?.songName
            self.songListinerCountLabel.text = cellData?.author
            self.songMinDurationLabel.text = cellData?.duration
            self.pictureUrlString = cellData!.pictureStringUrl
        }
    }
    
    private var pictureUrlString : String = ""
    
    private let songImage : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: K.ChooseSongVc.song1Img)
        img.layer.cornerRadius = 20
        img.clipsToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private let songNameLabel : UILabel = {
        let lb = UILabel()
        lb.font = .alegreyaSansMedium20()
        lb.textAlignment = .left
        lb.textColor = .white
        lb.text = "Painting Forest"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let songListinerCountLabel : UILabel = {
        let lb = UILabel()
        lb.font = .alegreyaSansLight12()
        lb.textAlignment = .left
        lb.textColor = .white
        lb.text = "59899 Listening"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let songMinDurationLabel : UILabel = {
        let lb = UILabel()
        lb.font = .alegreyaSansMedium15()
        lb.textAlignment = .left
        lb.textColor = .white
        lb.text = "20 Min"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let titlesStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .leading
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let contentStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 10
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(contentStack)
        contentStack.addArrangedSubview(songImage)
        contentStack.addArrangedSubview(titlesStack)
        titlesStack.addArrangedSubview(songNameLabel)
        titlesStack.addArrangedSubview(songListinerCountLabel)
        contentStack.addArrangedSubview(songMinDurationLabel)
        
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            contentStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            contentStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            contentStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func loadImagwFromURL(urlString: String) {
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.async {
                    self.songImage.image = UIImage(data: data)
                }
            }

            task.resume()
        }
    }
}
