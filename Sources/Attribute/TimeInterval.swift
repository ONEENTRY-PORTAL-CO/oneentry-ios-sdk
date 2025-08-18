//
//  TimeInterval.swift
//  OneEntry
//
//  Created by Archibbald on 17.08.2025.
//

import Foundation

import OneEntryShared

public extension OneEntryShared.TimeInterval.TimeIntervalValue {
    var dates: [Foundation.Date] {
        _dates.map { Foundation.Date(kotlin: $0) }
    }
    
    var times: [[Foundation.DateComponents]] {
        _times.map { times in times.map { Foundation.DateComponents(kotlin: $0) } }
    }
}
