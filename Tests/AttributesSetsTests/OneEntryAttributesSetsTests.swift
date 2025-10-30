//
//  OneEntryAttributesSetsTests.swift
//  OneEntry
//
//  Created by Archibbald on 1/6/25.
//

import Testing

import OneEntryCore
import OneEntryShared
import OneEntryAttributesSets
import OneEntryFoundationTests

struct OneEntryAttributesSetsTests {
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
    func attributes() async throws {
        let attributes = try await AttributesSetsService.shared.attributes(marker: "all")
        
        var general: Attribute.General? = nil
        var list: Attribute.List? = nil
        var entity: Attribute.Entity? = nil
        var interval: Attribute.TimeInterval? = nil
        
        for attribute in attributes {
            switch attribute {
                case .general(let attribute):
                    general = attribute
                case .list(let attribute):
                    list = attribute
                case .entity(let attribute):
                    entity = attribute
                case .timeInterval(let attribute):
                    interval = attribute
            }
        }
        
        #expect(general != nil)
        #expect(list != nil)
        #expect(entity != nil)
        #expect(interval != nil)
    }
    
    @Test
    func singleAttribute() async throws {
        let attribute = try await AttributesSetsService.shared.attribute(setMarker: "all", attributeMarker: "list")
        
        guard case .list(let list) = attribute else { Issue.record("A list type attribute was expected"); return }

        #expect(attribute.marker == list.marker)
        #expect(!list.listTitles.isEmpty)
    }
}
