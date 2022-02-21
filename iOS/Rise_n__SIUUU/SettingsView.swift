//
//  SettingsView.swift
//  Rise-n-SIUUU
//
//  Created by Neil Khatri on 10/1/22.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.colorScheme) var currentMode
    @AppStorage("sound") private var sound = "SIUUU_Notification_Loop.mp3"
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
            }
            Text("Options")
                .font(.system(size: 40, weight: .medium))
            
            Text("Pick your preferred alarm sound:")
                .padding(.top, 5)
            Picker(selection: $sound, label: Text("Pick your preferred alarm sound")) {
                Text("Looped SIUUU (default)").tag("SIUUU_Notification_Loop.mp3")
                Text("Single SIUUU").tag("SIUUU_Audio.mp3")
            }
            .pickerStyle(.segmented)
            
            Spacer()
        }
        .padding([.leading, .trailing], 20)
        .background(Color("customBackgroundColour").edgesIgnoringSafeArea(.all))
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            SettingsView().preferredColorScheme($0)
        }
    }
}
