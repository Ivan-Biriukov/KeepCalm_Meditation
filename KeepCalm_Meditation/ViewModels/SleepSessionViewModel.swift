import Foundation
import UIKit

class SleepSessionViewModel {
    
    static let shared = SleepSessionViewModel()
    
    private var timer : Timer?
    
    var sleepTimerStatus = Dynamic(SleepTimerDataModel(hours: Int(), minuts: Int(), seconds: Int()))
    var startSleepDate : String = ""
    var finishSleepDate : String = ""
    
    func startSleepTimer() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd hh:mm:ss"
        let dateString = dateFormatter.string(from: Date.init())
        
        self.startSleepDate = dateString
        
         timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(sleepTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func sleepTimer() {
        if sleepTimerStatus.value.seconds < 60 {
            sleepTimerStatus.value.seconds += 1
        } else {
            if sleepTimerStatus.value.minuts < 60 {
                sleepTimerStatus.value.minuts += 1
                sleepTimerStatus.value.seconds = 0
            } else {
                sleepTimerStatus.value.hours += 1
                sleepTimerStatus.value.minuts = 0
                sleepTimerStatus.value.seconds = 0
            }
        }
    }
    
    func pauseTimer() {
        self.timer?.invalidate()
    }
    
    func stopTimer() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd hh:mm:ss"
        let dateString = dateFormatter.string(from: Date.init())
        
        self.finishSleepDate = dateString
        
        self.calculateSleepTimeDifference(startDate: startSleepDate, endDate: finishSleepDate)
        
        self.timer?.invalidate()
        sleepTimerStatus.value = SleepTimerDataModel(hours: 0, minuts: 0, seconds: 0)
    }
    
    var sleepDuration = Dynamic("")
    
    func calculateSleepTimeDifference(startDate: String, endDate: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateAsString = startDate
        let date1 = dateFormatter.date(from: dateAsString)!
        
        let dateAsString2 = endDate
        let date2 = dateFormatter.date(from: dateAsString2)!
        
        let components : NSCalendar.Unit = [.second, .minute, .hour, .day, .month, .year]

        let difference = (Calendar.current as NSCalendar).components(components, from: date1, to: date2, options: [])
        
        var dateTimeDifferenceString = ""
        
        if difference.day != 0 {
            dateTimeDifferenceString = "\(difference.day!)d \(difference.hour!)h \(difference.minute!)m"
        } else if  difference.day == 0 {
            dateTimeDifferenceString = "\(difference.hour!)h \(difference.minute!)m"
        }
        
        self.sleepDuration.value = dateTimeDifferenceString
    }
    
}
