//
//  Test.swift
//  OneEntry
//
//  Created by Archibbald on 12/17/24.
//

import Testing

import OneEntryShared
import OneEntryCatalog
import OneEntryCore
import OneEntryPages
import OneEntryFoundationTests

struct CatalogTest {
    init() async throws {
        let config = try TestConfig.load()
        
        OneEntryApp.shared.initialize(
            host: config.host,
            token: config.token
        ) {
            LogLevel(.all)
        }
    }
    
    @Test
    func all() async throws {
        let result = try await CatalogService.shared.all {
            ConditionBlock(
                attributeMarker: "price",
                conditionMarker: .greaterThen,
                conditionValue: .init(double: 10.0)
            )
        }
        
        for item in result.items() {
            let price = try #require(item.price?.doubleValue)
            
            #expect(price > 10.0)
        }
    }
    
    @Test
    func byPageWithID() async throws {
        let page = try await PagesService.shared.page(url: "dev", langCode: "en_US")
        let result = try await CatalogService.shared.byPage(id: .init(page.id)) {
            ConditionBlock(
                attributeMarker: "price",
                conditionMarker: .greaterThen,
                conditionValue: .init(double: 10.0)
            )
        }
        
        for item in result.items() {
            let price = try #require(item.price?.doubleValue)
            
            #expect(price > 10.0)
        }
    }
    
    @Test
    func byPageWithURL() async throws {
        let result = try await CatalogService.shared.byPage(url: "dev") {
            ConditionBlock(
                attributeMarker: "price",
                conditionMarker: .greaterThen,
                conditionValue: .init(double: 10.0)
            )
        }
        
        for item in result.items() {
            let price = try #require(item.price?.doubleValue)
            
            #expect(price > 10.0)
        }
    }
}
