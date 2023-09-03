import SwiftUI

struct ContentView: View {
    @EnvironmentObject var notificationManager: NotificationManager
    
    var body: some View {
        VStack {
            Text("Select Time")
                .font(.title)
            
            DatePicker("Select Time", selection: $notificationManager.selectedTime, displayedComponents: .hourAndMinute)
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
            
            Text("Selected Time: \(formattedTime)")
            
            SetAlarmButton()
            
            if notificationManager.alarmSet {
                Text("Alarm has been set!")
                    .foregroundColor(.green)
                    .padding(.top, 10)
            }
        }
        .onAppear {
            notificationManager.checkAlarmTime()
        }
        .padding()
    }
    
    private var formattedTime: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: notificationManager.selectedTime)
    }
}

struct SetAlarmButton: View {
    @EnvironmentObject var notificationManager: NotificationManager
    
    var body: some View {
        Button(action: {
            
            notificationManager.scheduleNotification()
        }) {
            Text("Set Alarm")
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: 220, height: 50)
                .background(Color(UIColor(red: 0.1, green: 0.4, blue: 0.7, alpha: 1.0)))
                .cornerRadius(20)
        }
    }
}
