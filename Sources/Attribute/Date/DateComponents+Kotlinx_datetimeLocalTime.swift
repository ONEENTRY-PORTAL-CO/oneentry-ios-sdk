//
//  DateComponents+Kotlinx_datetimeLocalTime.swift
//  OneEntry
//
//  Created by Archibbald on 18.08.2025.
//

import Foundation

import OneEntryShared

extension Foundation.DateComponents {
    init(kotlin time: Kotlinx_datetimeLocalTime) {
        self.init(
            hour: Int(time.hour),
            minute: Int(time.minute),
            second: Int(time.second),
            nanosecond: Int(time.nanosecond)
        )
    }
}
