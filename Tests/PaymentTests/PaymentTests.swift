//
//  PaymentTests.swift
//  OneEntry
//
//  Created by Archibbald on 2/18/25.
//

import Testing

import OneEntryAuth
import OneEntryCore
import OneEntryShared
import OneEntryPayments
import OneEntryFoundationTests

struct PaymentTests {
    let authProviderMarker = "email"
    let userIdentifier = "artikdanilov@gmail.com"
    
    init() async throws {
        let config = try TestConfig.load()
        
        OneEntryApp.shared.initialize(
            host: config.host,
            token: config.token
        ) {
            LogLevel(.all)
        }
        
        try await AuthProviderService.shared.auth(marker: authProviderMarker) {
            AuthData(marker: "email_auth", value: userIdentifier)
            AuthData(marker: "pass_auth", value: "password")
        }
    }
    
    @Test
    func create() async throws {
        let result = try await OrdersService.shared.all(
            marker: "delivery",
            offset: 0,
            limit: 1,
            langCode: "en_US"
        )
        
        let order = try #require(result.items().first)
        
        try await PaymentsService.shared.purchase(
            orderId: order.id,
            type: .intent,
            automaticTaxEnabled: true
        )
        
        try await PaymentsService.shared.purchase(
            orderId: order.id,
            type: .session,
            automaticTaxEnabled: true
        )
    }
    
    @Test
    func sessions() async throws {
        let result = try await PaymentsService.shared.sessions(
            offset: 0,
            limit: 30
        )
        
        let payments = result.items()
        
        #expect(payments.contains { $0 is PaymentSession.Intent })
        #expect(payments.contains { $0 is PaymentSession.Session })
        #expect(result.total > 0)
    }
    
    @Test
    func accounts() async throws {
        let accounts = try await PaymentsService.shared.accounts()
        
        #expect(!accounts.isEmpty)
    }
}
