//
//  PaymentAccount.swift
//  OneEntry
//
//  Created by Archibbald on 27.10.2025.
//

import Foundation

import OneEntryCore

@preconcurrency import OneEntryShared

@dynamicMemberLookup
public enum PaymentAccount {
    case stripe(Stripe)
    case custom(Custom)
}

extension PaymentAccount {
    init(dto: some _PaymentAccount) throws {
        self = switch dto {
            case let account as _PaymentAccountStripe:
                    .stripe(account)
            case let account as _PaymentAccountCustom:
                    .custom(account)
            default:
                throw SealedClassMappingError(unknown: dto)
        }
    }
    
    var account: _PaymentAccount {
        switch self {
            case .stripe(let stripe):
                stripe
            case .custom(let custom):
                custom
        }
    }
}

public extension PaymentAccount {
    typealias Stripe = _PaymentAccountStripe
    typealias Custom = _PaymentAccountCustom
    
    struct SealedClassMappingError: LocalizedError {
        let unknown: _PaymentAccount
        
        public var errorDescription: String? {
            String(localized: "Unknown payment account type: ") + String(describing: unknown)
        }
    }
    
    subscript<T>(dynamicMember keyPath: KeyPath<_PaymentAccount, T>) -> T {
        account[keyPath: keyPath]
    }
}
