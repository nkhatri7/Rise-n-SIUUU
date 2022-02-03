//
//  HelpView.swift
//  Rise-n-SIUUU
//
//  Created by Neil Khatri on 10/1/22.
//

import SwiftUI

struct HelpView: View {
    @Environment(\.colorScheme) var currentMode
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
            }
            Text("Help")
                .font(.system(size: 40, weight: .medium))
            
            Text("To hear the SIUUU alarm, your phone must have silent mode switched off.")
                .padding([.top, .bottom], 5)
            Text("If you want to put on Do Not Disturb while you sleep, make this app an exception by going to Do Not Disturb in Settings and choose Rise n' SIUUU in allowed notifications.")
            Spacer()
        }
        .padding([.leading, .trailing], 20)
        .background(Color("customBackgroundColour").edgesIgnoringSafeArea(.all))
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            HelpView().preferredColorScheme($0)
        }
    }
}
