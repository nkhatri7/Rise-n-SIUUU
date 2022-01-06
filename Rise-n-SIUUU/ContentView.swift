//
//  ContentView.swift
//  Rise-n-SIUUU
//
//  Created by Neil Khatri on 6/1/22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var currentMode
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
            }
            if (currentMode == .dark) {
                Image("Rise-n-SIUUU-title-dark")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .padding()
            } else {
                Image("Rise-n-SIUUU-title")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .padding()
            }
            Spacer()
            Button("Request Permission") {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { success, error in
                    if success {
                        print("Successful")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
            
            Button("Schedule Notification") {
                let content = UNMutableNotificationContent()
                content.title = "Rise n' SIUUU"
                content.subtitle = "SIUUUUUUUU"
                content.sound = UNNotificationSound.init(named: UNNotificationSoundName(rawValue: "SIUUU_Audio.mp3"))
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request)
            }
            Spacer()
            Spacer()
        }
        .background(Color("customBackgroundColour").edgesIgnoringSafeArea(.all))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            ContentView().preferredColorScheme($0)
        }
    }
}
