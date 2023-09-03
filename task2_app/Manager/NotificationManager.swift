
import Foundation
import UserNotifications
import AVFoundation

class NotificationManager: ObservableObject {
    @Published var selectedTime = Date()
    @Published var alarmSet = false
    private let notificationCenter = UNUserNotificationCenter.current()
    private var audioPlayer: AVAudioPlayer?
    
    init() {
        notificationCenter.requestAuthorization(options: [.alert, .sound]) { _, _ in }
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Wake up!"
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "ringtone.mp3"))
        
        let triggerDate = Calendar.current.dateComponents([.hour, .minute], from: selectedTime)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        let request = UNNotificationRequest(identifier: "alarmNotification", content: content, trigger: trigger)
        
        notificationCenter.add(request) { [weak self] error in
            if let error = error {
                print("Error adding notification request: \(error)")
            } else {
                print("Notification request added successfully")
            }
        }
        
        alarmSet = true
    }
    
    func playIncreasingVolumeAlarmSound() {
        guard let soundURL = Bundle.main.url(forResource: "ringtone", withExtension: "mp3") else {
            print("Sound file not found")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.prepareToPlay()
            audioPlayer?.volume = 0.1
            audioPlayer?.play()
            
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { [weak self] timer in
                guard let self = self else {
                    timer.invalidate()
                    return
                }
                if let player = self.audioPlayer, player.isPlaying {
                    if player.volume < 1.0 {
                        player.volume += 0.05
                    } else {
                        timer.invalidate()
                    }
                } else {
                    timer.invalidate()
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
                self.audioPlayer?.stop()
                self.audioPlayer?.volume = 0.1
            }
        } catch {
            print("Error playing alarm sound: \(error)")
        }
    }
    
    
    
    func checkAlarmTime() {
        let currentTime = Date()
        
        if alarmSet && selectedTime <= currentTime {
            
        }
    }
}
