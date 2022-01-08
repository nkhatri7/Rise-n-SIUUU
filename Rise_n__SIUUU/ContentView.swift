//
//  ContentView.swift
//  Rise n' SIUUU
//
//  Created by Neil Khatri on 6/1/22.
//

import SwiftUI
import UserNotifications

// Lifted from @Mojtaba Hosseini's answer on StackOverflow: https://stackoverflow.com/questions/58632188/swiftui-add-border-to-one-edge-of-an-image
struct EdgeBorder: Shape {

    var width: CGFloat
    var edges: [Edge]

    func path(in rect: CGRect) -> Path {
        var path = Path()
        for edge in edges {
            var x: CGFloat {
                switch edge {
                case .top, .bottom, .leading: return rect.minX
                case .trailing: return rect.maxX - width
                }
            }

            var y: CGFloat {
                switch edge {
                case .top, .leading, .trailing: return rect.minY
                case .bottom: return rect.maxY - width
                }
            }

            var w: CGFloat {
                switch edge {
                case .top, .bottom: return rect.width
                case .leading, .trailing: return self.width
                }
            }

            var h: CGFloat {
                switch edge {
                case .top, .bottom: return self.width
                case .leading, .trailing: return rect.height
                }
            }
            path.addPath(Path(CGRect(x: x, y: y, width: w, height: h)))
        }
        return path
    }
}

extension View {
    func border(width: CGFloat, edges: [Edge], color: Color) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
    }
}

struct ContentView: View {
    @Environment(\.colorScheme) var currentMode
    @AppStorage("hour") private var hour = 100
    @AppStorage("minute") private var minute = 100
    @AppStorage("active") private var active = true
    
    func formatNumber(number: Int) -> String {
        return number < 10 ? "0\(number)" : "\(number)"
    }
    
    func displayAlarmTime() -> String {
        if hour == 0 {
            return("12:\(formatNumber(number: minute))am")
        } else if hour < 12 {
            return ("\(hour):\(formatNumber(number: minute))am")
        } else {
            return ("\(hour - 12):\(formatNumber(number: minute))pm")
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                }
                Image(currentMode == .dark ? "Rise-n-SIUUU-title-dark" : "Rise-n-SIUUU-title")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .padding()
                Spacer()
    //            Button("Request Permission") {
    //                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { success, error in
    //                    if success {
    //                        print("Successful")
    //                    } else if let error = error {
    //                        print(error.localizedDescription)
    //                    }
    //                }
    //            }
                if (hour == 100) {
                    NavigationLink(destination: TimeSelectorView()) {
                        Text("Set an alarm")
                            .foregroundColor(Color.white)
                            .font(.system(size: 24, weight: Font.Weight.semibold))
                            .frame(width: 200, height: 75)
                            .background(Color.red)
                            .cornerRadius(50)
                    }
                } else {
                    NavigationLink(destination: TimeSelectorView()) {
                        HStack {
                            Text(displayAlarmTime())
                                .font(.system(size: 48, weight: Font.Weight.light))
                                .foregroundColor(active ? currentMode == .dark ? Color.white : Color.black : Color.gray)
                                .padding()
                            Spacer()
                            Toggle("Active", isOn: $active)
                                .labelsHidden()
                                .padding(.trailing, 20)
                                .onChange(of: active) { value in
                                    if active {
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
                                    } else {
                                        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                                    }
                                }
                            Image(systemName: "chevron.right")
                                .foregroundColor(Color.gray)
                                .imageScale(.large)
                                .padding(.trailing, 10)
                        }
                        .border(width: 1, edges: [.top, .bottom], color: Color.gray.opacity(0.25))
                        .onAppear {
                            UNUserNotificationCenter.current().getPendingNotificationRequests(completionHandler: { notifications in
                                if notifications == [] {
                                    active = false
                                }
                            })
                        }
                    }
                }
                Spacer()
                Spacer()
                Spacer()
                Spacer()
            }
            .background(Color("customBackgroundColour").edgesIgnoringSafeArea(.all))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            ContentView().preferredColorScheme($0)
        }
    }
}
