//
//  TimeSelectorView.swift
//  Rise-n-SIUUU
//
//  Created by Neil Khatri on 7/1/22.
//

import SwiftUI
import UserNotifications

struct TimeSelectorView: View {
    @Environment(\.colorScheme) var currentMode
    @State private var currentTime = Date.now
    @AppStorage("hour") private var hour = 0
    @AppStorage("minute") private var minute = 0
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
            }
            
            Text("Add Alarm")
                .font(.title)
            Text("Select a time for your alarm")
                .font(.system(size: 20, weight: .semibold))
            
            Spacer()
            
            DatePicker("Pick a time", selection: $currentTime, displayedComponents: .hourAndMinute)
                .labelsHidden()
            
            Spacer()
            Spacer()
            
            Button("Save", action: {
                let calendar = Calendar.current
                
                hour = calendar.component(.hour, from: currentTime)
                minute = calendar.component(.minute, from: currentTime)
                
                let content = UNMutableNotificationContent()
                content.title = "Rise n' SIUUU"
                content.subtitle = "SIUUUUUUUU"
                content.sound = UNNotificationSound.init(named: UNNotificationSoundName(rawValue: "SIUUU_Audio.mp3"))

                var dateComponents = DateComponents()
                dateComponents.calendar = Calendar.current
                dateComponents.hour = hour
                dateComponents.minute = minute

                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                UNUserNotificationCenter.current().add(request)
            })
                .foregroundColor(Color.white)
                .font(.system(size: 20, weight: Font.Weight.semibold))
                .frame(width: 150, height: 60)
                .background(Color.red)
                .cornerRadius(50)
        }
        .background(Color("customBackgroundColour").edgesIgnoringSafeArea(.all))
    }
}

struct TimeSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            TimeSelectorView().preferredColorScheme($0)
        }
    }
}
