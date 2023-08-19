import UIKit
import AVFoundation

class ChartListViewController: UIViewController {
    
    private var player : AVPlayer?
    
    private var currentSongIndexPath : Int = 0
    
    private var loopedAudioEnabled : Bool = false
    private var shuffledEnabled : Bool = false
    private var isPlayerPlaying : Bool = false
    
    // MARK: - UI Elements
    
    private let chartTableView : UITableView = {
        let tb = UITableView()
        tb.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 20).isActive = true
        tb.translatesAutoresizingMaskIntoConstraints = false
        return tb
    }()
    
    private let songProgress : UIProgressView = {
        let pg = UIProgressView()
        pg.progress = 0
        pg.progressViewStyle = .bar
        pg.trackTintColor = .lightGray
        pg.progressTintColor = .darkGray
        pg.heightAnchor.constraint(equalToConstant: 5).isActive = true
        pg.translatesAutoresizingMaskIntoConstraints = false
        return pg
    }()
    
    private lazy var playerButtonsStack : UIStackView = {
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
        setupConstraints()
        setupTableView()
        addButtonsTargets()
    }
    
    // MARK: -  Buttons Methods
    
    @objc private func playerButtonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 5:
            shuffledEnabled = !shuffledEnabled
            if shuffledEnabled {
                shuffleButton.tintColor = .systemGreen
            } else {
                shuffleButton.tintColor = .white
            }

        case 6:
            if currentSongIndexPath > 0 {
                currentSongIndexPath -= 1
                chartTableView.selectRow(at: IndexPath.init(row: currentSongIndexPath, section: 0), animated: true, scrollPosition: .top)
            } else {
                currentSongIndexPath = 0
            }
        case 7:
            isPlayerPlaying = !isPlayerPlaying
            if isPlayerPlaying {
                playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
                player?.play()
            } else {
                playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
                player?.pause()
            }
            
        case 8:
            if currentSongIndexPath < MusicModelManager.shared.musicDataArray.count - 1 {
                currentSongIndexPath += 1
                chartTableView.selectRow(at: IndexPath.init(row: currentSongIndexPath, section: 0), animated: true, scrollPosition: .top)
            } else {
                currentSongIndexPath = 0
            }
        case 9:
            loopedAudioEnabled = !loopedAudioEnabled
            if loopedAudioEnabled {
                reverseButton.tintColor = .systemGreen
            } else {
                reverseButton.tintColor = .white
            }
        default:
            print("cant be execute")
        }
    }
    
    // MARK: - Work Methods
    
    func loadTrack(trackURL: String) {
            guard let url = URL.init(string: trackURL) else { return }
            let playerItem = AVPlayerItem.init(url: url)
            player = AVPlayer.init(playerItem: playerItem)
        }
    
    // MARK: - Configure UI
    
    private func setupTableView() {
        chartTableView.delegate = self
        chartTableView.dataSource = self
        chartTableView.backgroundColor = .clear
        chartTableView.register(SongsTableViewCell.self, forCellReuseIdentifier: "chartCell")
    }
    
    private func addButtonsTargets() {
        var tagValue = 5
        for button in [shuffleButton, backwardButton, playPauseButton, forwardButton, reverseButton] {
            button.addTarget(self, action: #selector(playerButtonPressed(_:)), for: .touchUpInside)
            button.tag = tagValue
            tagValue += 1
        }
    }
    
    private func addSubviews() {
        view.addSubview(chartTableView)
        view.addSubview(songProgress)
        view.addSubview(playerButtonsStack)
        playerButtonsStack.addArrangedSubview(shuffleButton)
        playerButtonsStack.addArrangedSubview(backwardButton)
        playerButtonsStack.addArrangedSubview(playPauseButton)
        playerButtonsStack.addArrangedSubview(forwardButton)
        playerButtonsStack.addArrangedSubview(reverseButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            chartTableView.topAnchor.constraint(equalTo: view.topAnchor),
            chartTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            chartTableView.bottomAnchor.constraint(equalTo: songProgress.topAnchor,constant: -10),
            
            songProgress.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            songProgress.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            songProgress.bottomAnchor.constraint(equalTo: playerButtonsStack.topAnchor, constant: -20),
            playerButtonsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            playerButtonsStack.trailingAnchor
                .constraint(equalTo: view.trailingAnchor, constant: -20),
            playerButtonsStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
        ])
        
    }
}

// MARK: - TableView Delegate & DataSource

extension ChartListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MusicModelManager.shared.musicDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chartTableView.dequeueReusableCell(withIdentifier: "chartCell", for: indexPath) as! SongsTableViewCell
        
        let currentCellData = MusicModelManager.shared.musicDataArray[indexPath.row]
        cell.cellData = currentCellData
        cell.loadImagwFromURL(urlString: currentCellData.pictureStringUrl)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.currentSongIndexPath = indexPath.row
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        player?.pause()
        loadTrack(trackURL: MusicModelManager.shared.musicDataArray[indexPath.row].musicStringUrl)
        //player?.play()
    }
    
    
}
