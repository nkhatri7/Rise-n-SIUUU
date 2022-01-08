//
//  Alarm.swift
//  Rise-n-SIUUU
//
//  Created by Neil Khatri on 7/1/22.
//

import Foundation

struct Alarm: Codable {
    let id: String
    let hour: Int
    let minute: Int
    let active: Bool
}
