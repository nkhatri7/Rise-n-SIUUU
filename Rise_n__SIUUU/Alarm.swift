//
//  Alarm.swift
//  Rise n' SIUUU
//
//  Created by Neil Khatri on 7/1/22.
//

// Will be used in future updates for multiple alarms

import Foundation

struct Alarm: Codable {
    let id: String
    let hour: Int
    let minute: Int
    let active: Bool
}
