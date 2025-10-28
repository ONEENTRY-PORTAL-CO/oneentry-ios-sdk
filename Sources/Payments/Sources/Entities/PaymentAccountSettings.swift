//
//  PaymentAccountSettings.swift
//  OneEntry
//
//  Created by Archibbald on 27.10.2025.
//

import Foundation

@preconcurrency import OneEntryShared

public protocol PaymentAccountSettings: Sendable {
    associatedtype Connected
    associatedtype NotConnected
    
    var settings: Connected { get throws(PaymentAccountConnectionError) }
}

public extension PaymentAccountSettings where Connected: PaymentAccountSettings, NotConnected: PaymentAccountSettings {
    var settings: Connected {
        get throws(PaymentAccountConnectionError) {
            switch self {
                case let settings as Connected:
                    return settings
                case _ as NotConnected:
                    throw .notConnected
                default:
                    throw .unknownIntegrationStatus(self)
            }
        }
    }
}

extension _PaymentAccountStripe.Settings: PaymentAccountSettings {
    public typealias Connected = _PaymentAccountStripe.SettingsConnected
    public typealias NotConnected = _PaymentAccountStripe.SettingsNotConnected
}

extension _PaymentAccountCustom.Settings: PaymentAccountSettings {
    public typealias Connected = _PaymentAccountCustom.SettingsConnected
    public typealias NotConnected = _PaymentAccountCustom.SettingsNotConnected
}
