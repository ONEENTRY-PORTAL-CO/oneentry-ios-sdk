//
//  Kotlinx_datetimeLocalDateTime+Date.swift
//  OneEntry
//
//  Created by Archibbald on 15.08.2025.
//

import Foundation

import OneEntryShared

public extension Kotlinx_datetimeLocalDateTime {
    convenience init(date: Foundation.Date, calendar: Calendar) {
        let components = calendar.dateComponents(
            [.year, .month, .day, .hour, .minute, .second, .nanosecond],
            from: date
        )
        
        self.init(components: components)
    }
    
    convenience init(components: DateComponents) {
        self.init(
            year: Int32(components.year ?? 0),
            month: Int32(components.month ?? 0),
            day: Int32(components.day ?? 0),
            hour: Int32(components.hour ?? 0),
            minute: Int32(components.minute ?? 0),
            second: Int32(components.second ?? 0),
            nanosecond: Int32(components.nanosecond ?? 0)
        )
    }
}
