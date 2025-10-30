//
//  AttributeTest.swift
//  OneEntry
//
//  Created by Archibbald on 12/3/24.
//

import Testing

import OneEntryCore
import OneEntryPages
import OneEntryShared
import OneEntryFoundationTests

struct AttributeTest {
    let page: Page
    
    let locale = "en_US"
    
    init() async throws {
        let config = try TestConfig.load()
        
        OneEntryApp.shared.initialize(
            host: config.host,
            token: config.token
        ) {
            LogLevel(.all)
        }
        
        self.page = try await PagesService.shared.page(url: "dev", langCode: locale)
    }

    @Test
    func regular() async throws {
        let attributes = try #require(page.attributeValues[locale])
        let attribute = try #require(attributes["string"])
        
        try #expect(attribute.valueAsString() == "String")
    }
    
    @Test
    func dsl() async throws {
        let attributes = try #require(page.content.attributes[locale])
        let attribute = try #require(attributes.string)
        
        try #expect(attribute.valueAsString() == "String")
    }
}
