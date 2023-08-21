import UIKit
import AVFoundation

class ChartListViewController: UIViewController {
    
    private var player : AVPlayer?
    
    private var currentTrack : Int = 0
    
    private var loopedAudioEnabled : Bool = false
    private var shuffledEnabled : Bool = false
    private var countsForShafledPlay = [0, 1, 2, 3, 4, 5, 6, 7, 8 , 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21]

    private var isPlayerPlaying : Bool = false
    
    private var songLists : [AVPlayerItem] = []
    
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
        loadTracksList()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(fileComplete),
            name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
            object: nil
        )
    }
    
    // MARK: -  Buttons Methods
    
    @objc private func playerButtonPressed(_ sender: UIButton) {
        switch sender.tag {
            
        case 5:  // randome
            shuffledEnabled = !shuffledEnabled
            if shuffledEnabled {
                shuffleButton.tintColor = .systemGreen
            } else {
                shuffleButton.tintColor = .white
            }

        case 6: // backward
            previousTrack()
            chartTableView.selectRow(at: IndexPath.init(row: currentTrack, section: 0), animated: true, scrollPosition: .top)
            isPlayerPlaying = true
            updatePlayButtonUI(isPlayingNow: isPlayerPlaying)
            
        case 7: // play pause
            isPlayerPlaying = !isPlayerPlaying
            updatePlayButtonUI(isPlayingNow: isPlayerPlaying)

            
        case 8:  // forward
            nextTrack()
            chartTableView.selectRow(at: IndexPath.init(row: currentTrack, section: 0), animated: true, scrollPosition: .top)
            isPlayerPlaying = true
            updatePlayButtonUI(isPlayingNow: isPlayerPlaying)

        case 9: // repeat one
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
    
    // MARK: - Player Work Methods
    
    private func loadTracksList() {
        for songUrl in MusicModelManager.shared.musicDataArray {
            let url = URL(string: songUrl.musicStringUrl)
            self.songLists.append(AVPlayerItem(url: url!))
        }
        player = AVPlayer()
    }
    
   private func previousTrack() {
        if currentTrack - 1 < 0 {
            currentTrack = (songLists.count - 1) < 0 ? 0 : (songLists.count - 1)
        } else {
            currentTrack -= 1
        }
        playTrack()
       print(currentTrack)
    }
    
    private func nextTrack() {
        if currentTrack + 1 > songLists.count {
            currentTrack = 0
        } else {
            currentTrack += 1;
        }
        playTrack()
    }
    
    private func playTrack() {
        if songLists.count > 0 {
            player?.replaceCurrentItem(with: songLists[currentTrack])
            player?.play()
        }
    }
    
    private func playRandomTrack() {
        countsForShafledPlay.shuffle()
        let firstAfterShafle = countsForShafledPlay.first!
        chartTableView.selectRow(at: IndexPath.init(row: firstAfterShafle, section: 0), animated: true, scrollPosition: .top)
        
        player?.replaceCurrentItem(with: songLists[firstAfterShafle])
        player?.play()
        songLists.removeFirst()
    }
    
    private func playPuse() {
        isPlayerPlaying == true ? player?.play() : player?.pause()
    }
    
    @objc func fileComplete() {
        if loopedAudioEnabled {
            
//            player?.replaceCurrentItem(with: songLists[currentTrack])
//            player?.play()
        } else {
            if currentTrack + 1 < songLists.count {
                currentTrack += 1
                chartTableView.selectRow(at: IndexPath.init(row: currentTrack, section: 0), animated: true, scrollPosition: .top)
                player?.replaceCurrentItem(with: songLists[currentTrack])
                player?.play()
            } else {
                currentTrack = 0
                chartTableView.selectRow(at: IndexPath.init(row: currentTrack, section: 0), animated: true, scrollPosition: .top)
                player?.replaceCurrentItem(with: songLists[currentTrack])
                player?.pause()
            }
        }
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
    
    private func updatePlayButtonUI(isPlayingNow: Bool) {
        if isPlayingNow {
            playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        } else {
            playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
        playPuse()
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
        self.currentTrack = indexPath.row
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        player?.pause()
        player?.replaceCurrentItem(with: songLists[currentTrack])
        isPlayerPlaying = true
        updatePlayButtonUI(isPlayingNow: isPlayerPlaying)
    }
}
