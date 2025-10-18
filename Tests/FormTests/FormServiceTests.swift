//
//  FormServiceTests.swift
//  OneEntry
//
//  Created by Archibbald on 12/24/24.
//

import Testing

import OneEntryFoundationTests
import OneEntryAttribute
import OneEntryShared
import OneEntryForm
import OneEntryCore

struct FormServiceTests {
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
    func sendData() async throws {                
        let home = "home"
        let comment = "comment"
        let formIdentifier = "delivery"
        let form = try await FormsService.shared.form(marker: formIdentifier, langCode: "langCode")
        let config = try #require(form.moduleFormConfigs?.randomElement())
        let entityIdentifier = try #require(config.entityIdentifiers?.randomElement())
        let entity = try await FormsService.shared.sendData(
            formIdentifier: formIdentifier,
            formModuleConfigId: Int(config.id),
            moduleEntityIdentifier: entityIdentifier.id)
        {
            Locale("en_US") {
                FormData(marker: "address", attribute: .init(string: home))
                FormData(marker: "comment", attribute: .init(string: comment))
                FormData(marker: "entrance", attribute: .init(int: 1))
            }
        }
        
        let resultHome = try #require(
            try? entity.formData.formData["en_US"]?
                .first { $0.marker == "address" }?
                .valueAsString()
        )
        
        let resultComment = try #require(
            try? entity.formData.formData["en_US"]?
                .first { $0.marker == "comment" }?
                .valueAsString()
        )
        
        #expect(resultHome == home)
        #expect(resultComment == comment)
    }
}
