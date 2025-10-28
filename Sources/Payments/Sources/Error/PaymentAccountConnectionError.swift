//
//  PaymentAccountConnectionError.swift
//  OneEntry
//
//  Created by Archibbald on 28.10.2025.
//

import Foundation

public enum PaymentAccountConnectionError: LocalizedError {
    case notConnected
    case unknownIntegrationStatus(any PaymentAccountSettings)
    
    public var errorDescription: String? {
        switch self {
            case .notConnected:
                String(localized: "The billing account exists, but the integration is incomplete")
            case .unknownIntegrationStatus(let integration):
                String(localized: "Unknown integration status: ") + String(describing: integration)
        }
    }
}
