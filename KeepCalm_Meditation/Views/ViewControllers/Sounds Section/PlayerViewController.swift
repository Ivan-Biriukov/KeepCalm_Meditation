import UIKit
import AVFoundation

class PlayerViewController: UIViewController, PlayerButtonsDelegate {
    
    private let pictureURL : String
    private let songName : String
    private let songAuthor : String
    private let songDuration : String
    private let songURL : String
    private let shuffleEnabled : Bool
    
    // MARK: - UI Elements
    
    var player : AVPlayer?
    
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
        view.clipsToBounds = true
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
        configureUIFromData()
        loadSongImage()
        loadRadio(radioURL: songURL)
        chekForShuffle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    init(pictureURL: String, songName: String, songAuthor: String, songDuration: String, songURL: String, shuffleEnabled: Bool) {
        self.pictureURL = pictureURL
        self.songName = songName
        self.songAuthor = songAuthor
        self.songDuration = songDuration
        self.songURL = songURL
        self.shuffleEnabled = shuffleEnabled
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Buttons Methods
    
    @objc func playerButtonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            let playerCurrentTime = CMTimeGetSeconds(player!.currentTime())
            var newTime = playerCurrentTime - 5
            if newTime < 0 {
                newTime = 0
            }
            let time2: CMTime = CMTimeMake(value: Int64(newTime * 1000 as Float64), timescale: 1000)
            player!.seek(to: time2, toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)
        case 2:
            if player?.timeControlStatus == .playing {
                player?.pause()
            } else {
                player?.play()
            }
        case 3:
            guard let duration  = player?.currentItem?.duration else {return}
            let playerCurrentTime = CMTimeGetSeconds(player!.currentTime())
            let newTime = playerCurrentTime + 5
            if newTime < (CMTimeGetSeconds(duration) - 5) {
                let time2: CMTime = CMTimeMake(value: Int64(newTime * 1000 as Float64), timescale: 1000)
                player!.seek(to: time2, toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)
            }
        default:
            print("cant be")
        }
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
    
    // MARK: - Configure UI
    
    private func addButtonsTarget() {
        var tag = 0
        let buttonArray = [shuffleButton, backwardButton, playPauseButton, forwardButton, reverseButton]
        for button in buttonArray {
            button.addTarget(self, action: #selector(playerButtonPressed(_:)), for: .touchUpInside)
            button.tag = tag
            tag += 1
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
    
    private func configureUIFromData() {
        self.songNameLabel.text = songName
        self.songAuthorLabel.text = songAuthor
    }
    
    private func chekForShuffle() {
        if shuffleEnabled {
            self.shuffleButton.isEnabled = true
            self.shuffleButton.setTitleColor(.white, for: .normal)
        } else {
            self.shuffleButton.isEnabled = false
            self.shuffleButton.setTitleColor(.gray, for: .normal)
        }
    }
  
    private func loadSongImage() {
        if let url = URL(string: pictureURL) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    self.songImage.image = UIImage(data: data)
                }
            }
            task.resume()
        }
    }
    
    private func fetchSongProgress() {
        
    }
    
    // MARK: - Player Methods
    
    func loadRadio(radioURL: String) {
            guard let url = URL.init(string: radioURL) else { return }
            let playerItem = AVPlayerItem.init(url: url)
            player = AVPlayer.init(playerItem: playerItem)
        }

}
