//
//  Date+KotlinInstant.swift
//  OneEntry
//
//  Created by Archibbald on 17.08.2025.
//

import Foundation

import OneEntryShared

extension Foundation.Date {
    init(kotlin instant: KotlinInstant) {
        let millis = instant.toEpochMilliseconds()
        
        self.init(timeIntervalSince1970: TimeInterval(millis) / 1000)
    }
}
