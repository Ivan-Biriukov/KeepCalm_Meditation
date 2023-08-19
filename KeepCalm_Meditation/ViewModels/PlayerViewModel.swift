import Foundation

class PlayerViewModel {
    static let shared = PlayerViewModel()
    
//    var musicStatus = Dynamic(MusicDataModel(songName: "", author: "", duration: "", musicStringUrl: "", pictureStringUrl: ""))
//
//    func updateMusicData(songName: String, authorName: String, duration: String, musicURL: String, pictureUrl: String) {
//        self.musicStatus.value = MusicDataModel(songName: songName, author: authorName, duration: duration, musicStringUrl: musicURL, pictureStringUrl: pictureUrl)
//    }
    
    func updateCurrentTackInList(value: Int) {
        UserDefaults.standard.set(value, forKey: "CurrentTackNumber")
    }
}
