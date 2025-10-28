//
//  PaymentsService.swift
//  OneEntry
//
//  Created by Archibbald on 28.10.2025.
//

import Foundation

@preconcurrency import OneEntryShared

public extension PaymentsService {
    func accounts() async throws -> [PaymentAccount] {
        let accounts = try await _accounts()
        
        return try accounts.map { try PaymentAccount(dto: $0) }
    }
    
    func account(id: Int) async throws -> PaymentAccount {
        let account = try await _accounts(id: Int32(id))
        
        return try PaymentAccount(dto: account)
    }
}
