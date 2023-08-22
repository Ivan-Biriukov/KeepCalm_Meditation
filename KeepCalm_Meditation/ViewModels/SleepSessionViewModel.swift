import Foundation
import UIKit

class SleepSessionViewModel {
    
    static let shared = SleepSessionViewModel()
    
    private var timer : Timer?
    
    var sleepTimerStatus = Dynamic(SleepTimerDataModel(hours: Int(), minuts: Int(), seconds: Int()))
    var startSleepDate : String = ""
    var finishSleepDate : String = ""
    
    func startSleepTimer() {
        sleepSessionStartedValue = Date()
        
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
        fetchSleepQuality(sleepStarted: sleepSessionStartedValue)
        deepSleepCalculating()
    }
    
    var sleepDuration = Dynamic("")
    var sleepDurationForCalculation = Dynamic("")
    
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
            self.sleepDurationForCalculation.value = "\(difference.day! * 24 + difference.hour!).\(difference.minute!)"
        } else if  difference.day == 0 {
            dateTimeDifferenceString = "\(difference.hour!)h \(difference.minute!)m"
            self.sleepDurationForCalculation.value = "\(difference.hour!).\(difference.minute!)"
        }
        self.sleepDuration.value = dateTimeDifferenceString
    }
    
    var sleepQualityStatus = Dynamic(Float())
    var sleepSessionStartedValue = Date()
    
    func fetchSleepQuality(sleepStarted : Date) {
        let df = DateFormatter()
        df.dateFormat = "HH"
        let dateString = df.string(from: sleepStarted)
        let startSleepIntHourValue = Int(dateString)
        
        let floatValueTotalHoursSleep : Float = (sleepDurationForCalculation.value as NSString).floatValue
        
        calculateSleepQualityValue(started: startSleepIntHourValue!, duration: floatValueTotalHoursSleep)
    }
    
    func calculateSleepQualityValue(started: Int, duration: Float) {
        var totalSleepDuration : Float = 0.0
        
        switch started {
        case 19:
            if duration > 1.0 {
                totalSleepDuration += 7.0
                if duration > 2.0 {
                    totalSleepDuration += 6.0
                } else if duration > 3.0 {
                    totalSleepDuration += 5.0
                } else if duration > 4.0 {
                    totalSleepDuration += 4.0
                } else if duration > 5.0 {
                    totalSleepDuration += 3.0
                } else if duration > 6.0 {
                    totalSleepDuration += 2.0
                } else if duration > 7.0 {
                    totalSleepDuration += 1.0
                } else if duration > 8.0 {
                    totalSleepDuration += 0.5
                } else if duration > 9.0 {
                    totalSleepDuration += 0.15
                } else if duration > 10.0 {
                    totalSleepDuration += 0.07
                } else if duration > 11.0 {
                    totalSleepDuration += 0.01
                }
            } else {
                totalSleepDuration += 7.0 * duration
            }
        case 20:
            if duration > 1.0 {
                totalSleepDuration += 6.0
                if duration > 2.0 {
                    totalSleepDuration += 5.0
                } else if duration > 3.0 {
                    totalSleepDuration += 4.0
                } else if duration > 4.0 {
                    totalSleepDuration += 3.0
                } else if duration > 5.0 {
                    totalSleepDuration += 2.0
                } else if duration > 6.0 {
                    totalSleepDuration += 1.0
                } else if duration > 7.0 {
                    totalSleepDuration += 0.5
                } else if duration > 8.0 {
                    totalSleepDuration += 0.15
                } else if duration > 9.0 {
                    totalSleepDuration += 0.07
                } else if duration > 10.0 {
                    totalSleepDuration += 0.01
                }
            } else {
                totalSleepDuration += 6.0 * duration
            }
        case 21:
            if duration > 1.0 {
                totalSleepDuration += 5.0
                if duration > 2.0 {
                    totalSleepDuration += 4.0
                } else if duration > 3.0 {
                    totalSleepDuration += 3.0
                } else if duration > 4.0 {
                    totalSleepDuration += 2.0
                } else if duration > 5.0 {
                    totalSleepDuration += 1.0
                } else if duration > 6.0 {
                    totalSleepDuration += 0.5
                } else if duration > 7.0 {
                    totalSleepDuration += 0.15
                } else if duration > 8.0 {
                    totalSleepDuration += 0.07
                } else if duration > 9.0 {
                    totalSleepDuration += 0.01
                }
            } else {
                totalSleepDuration += 5.0 * duration
            }
        case 22:
            if duration > 1.0 {
                totalSleepDuration += 4.0
                if duration > 2.0 {
                    totalSleepDuration += 3.0
                } else if duration > 3.0 {
                    totalSleepDuration += 2.0
                } else if duration > 4.0 {
                    totalSleepDuration += 1.0
                } else if duration > 5.0 {
                    totalSleepDuration += 0.5
                } else if duration > 6.0 {
                    totalSleepDuration += 0.15
                } else if duration > 7.0 {
                    totalSleepDuration += 0.07
                } else if duration > 8.0 {
                    totalSleepDuration += 0.01
                }
            } else {
                totalSleepDuration += 4.0 * duration
            }
        case 23:
            if duration > 1.0 {
                totalSleepDuration += 3.0
                if duration > 2.0 {
                    totalSleepDuration += 2.0
                } else if duration > 3.0 {
                    totalSleepDuration += 1.0
                } else if duration > 4.0 {
                    totalSleepDuration += 0.5
                } else if duration > 5.0 {
                    totalSleepDuration += 0.15
                } else if duration > 6.0 {
                    totalSleepDuration += 0.07
                } else if duration > 7.0 {
                    totalSleepDuration += 0.01
                }
            } else {
                totalSleepDuration += 3.0 * duration
            }
        case 0:
            if duration > 1.0 {
                totalSleepDuration += 2.0
                if duration > 2.0 {
                    totalSleepDuration += 1.0
                } else if duration > 3.0 {
                    totalSleepDuration += 0.5
                } else if duration > 4.0 {
                    totalSleepDuration += 0.15
                } else if duration > 5.0 {
                    totalSleepDuration += 0.07
                } else if duration > 6.0 {
                    totalSleepDuration += 0.01
                }
            } else {
                totalSleepDuration += 2.0 * duration
            }
        case 1:
            if duration > 1.0 {
                totalSleepDuration += 1.0
                if duration > 2.0 {
                    totalSleepDuration += 0.5
                } else if duration > 3.0 {
                    totalSleepDuration += 0.15
                } else if duration > 4.0 {
                    totalSleepDuration += 0.07
                } else if duration > 5.0 {
                    totalSleepDuration += 0.01
                }
            } else {
                totalSleepDuration += 1.0 * duration
            }
        case 2:
            if duration > 1.0 {
                totalSleepDuration += 0.5
                if duration > 2.0 {
                    totalSleepDuration += 0.15
                } else if duration > 3.0 {
                    totalSleepDuration += 0.07
                } else if duration > 4.0 {
                    totalSleepDuration += 0.01
                }
            } else {
                totalSleepDuration += 0.5 * duration
            }
        case 3:
            if duration > 1.0 {
                totalSleepDuration += 0.15
                if duration > 2.0 {
                    totalSleepDuration += 0.07
                } else if duration > 3.0 {
                    totalSleepDuration += 0.01
                }
            } else {
                totalSleepDuration += 0.15 * duration
            }
        case 4:
            if duration > 1.0 {
                totalSleepDuration += 0.07
                if duration > 2.0 {
                    totalSleepDuration += 0.01
                }
            } else {
                totalSleepDuration += 0.07 * duration
            }
        default:
            if duration > 1.0 {
                totalSleepDuration += 0.01
            } else {
                totalSleepDuration += 0.01 * duration
            }
        }
        self.sleepQualityStatus.value = totalSleepDuration
    }
    
    var deepSleepHoursValue = Dynamic("")
    
    func deepSleepCalculating() {
        let floatValueTotalHoursSleep : Float = (sleepDurationForCalculation.value as NSString).floatValue
        
        let result = (floatValueTotalHoursSleep * 40.0) / 100.0
        
        self.deepSleepHoursValue.value = String(format: "%.2f", result)
        
    }
}
