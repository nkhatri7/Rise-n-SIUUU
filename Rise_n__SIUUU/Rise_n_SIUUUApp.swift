//
//  Rise_n_SIUUUApp.swift
//  Rise n' SIUUU
//
//  Created by Neil Khatri on 6/1/22.
//

import SwiftUI

@main
struct Rise_n_SIUUUApp: App {
    
    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { success, error in
            if success {
                print("Successful")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
