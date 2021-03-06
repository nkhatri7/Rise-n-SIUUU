//
//  TimeSelectorView.swift
//  Rise n' SIUUU
//
//  Created by Neil Khatri on 7/1/22.
//

import SwiftUI
import UserNotifications

struct TimeSelectorView: View {
    @Environment(\.colorScheme) var currentMode
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @AppStorage("hour") private var hour = 100
    @AppStorage("minute") private var minute = 100
    @AppStorage("active") private var active = true
    @AppStorage("sound") private var sound = "SIUUU_Notification_Loop.mp3"
    @State private var alarmTime = Date()
    
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
            }
            
            Text(hour == 100 ? "Add Alarm" : "Edit Alarm")
                .font(.title)
            Text("Select a time for your alarm")
                .font(.system(size: 20, weight: .semibold))
            
            Spacer()
            
            DatePicker("Pick a time", selection: $alarmTime, displayedComponents: .hourAndMinute)
                .labelsHidden()
                .transformEffect(.init(scaleX: 1.7, y: 1.7))
                .frame(width: 170, height: 60, alignment: .topLeading)
            
            Spacer()
            Spacer()
            
            Button("Save", action: {
                let notificationController = NotificationController()
                if hour != 100 {
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                    notificationController.removeNotifications()
                }
                
                let calendar = Calendar.current
                hour = calendar.component(.hour, from: alarmTime)
                minute = calendar.component(.minute, from: alarmTime)
                
                notificationController.createNotification(hour: hour, minute: minute, sound: sound)
                active = true
                
                presentationMode.wrappedValue.dismiss()
            })
                .foregroundColor(Color.white)
                .font(.system(size: 20, weight: Font.Weight.semibold))
                .frame(width: 150, height: 60)
                .background(Color("brandRed"))
                .cornerRadius(50)
                .padding()
        }
        .background(Color("customBackgroundColour").edgesIgnoringSafeArea(.all))
        .onAppear(perform: getCurrentAlarmTime)
    }
    
    func getCurrentAlarmTime() {
        if (hour != 100) {
            var components = DateComponents()
            components.hour = hour
            components.minute = minute
            let date = Calendar.current.date(from: components)!
            alarmTime = date
        }
    }
}

struct TimeSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            TimeSelectorView().preferredColorScheme($0)
        }
    }
}
