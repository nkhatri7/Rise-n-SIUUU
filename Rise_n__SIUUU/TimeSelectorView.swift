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
    @State private var currentTime = Date()
    @AppStorage("hour") private var hour = 100
    @AppStorage("minute") private var minute = 100
    @AppStorage("active") private var active = true
    
    func createNotification(hour: Int, minute: Int) {
        let content = UNMutableNotificationContent()
        content.title = "Rise n' SIUUU"
        content.subtitle = "SIUUUUUUUU"
        content.sound = UNNotificationSound.init(named: UNNotificationSoundName(rawValue: "SIUUU_Notification_Loop.mp3"))

        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        dateComponents.hour = hour
        dateComponents.minute = minute

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request)
        
        active = true
    }
    
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
            
            DatePicker("Pick a time", selection: $currentTime, displayedComponents: .hourAndMinute)
                .labelsHidden()
                .transformEffect(.init(scaleX: 1.7, y: 1.7))
                .frame(width: 170, height: 60, alignment: .topLeading)
            
            Spacer()
            Spacer()
            
            Button("Save", action: {
                if hour == 100 {
                    let calendar = Calendar.current
                    
                    hour = calendar.component(.hour, from: currentTime)
                    minute = calendar.component(.minute, from: currentTime)
                    
                    createNotification(hour: hour, minute: minute)
                } else {
                    let calendar = Calendar.current
                    
                    hour = calendar.component(.hour, from: currentTime)
                    minute = calendar.component(.minute, from: currentTime)
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                    createNotification(hour: hour, minute: minute)
                }
                
                presentationMode.wrappedValue.dismiss()
            })
                .foregroundColor(Color.white)
                .font(.system(size: 20, weight: Font.Weight.semibold))
                .frame(width: 150, height: 60)
                .background(Color.red)
                .cornerRadius(50)
                .padding()
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
