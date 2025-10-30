//
//  StorageServiceTests.swift
//  OneEntry
//
//  Created by Archibbald on 12/31/24.
//

import Testing

import OneEntryStorage
import OneEntryShared
import OneEntryCore
import OneEntryFoundationTests

struct StorageServiceTests {
    var storage: [UploadResult] = []
    
    let paths = [
        "/Users/artur/AndroidStudioProjects/OneEntry/sdk-storage/src/commonTest/resources/dinar_1.png",
        "/Users/artur/AndroidStudioProjects/OneEntry/sdk-storage/src/commonTest/resources/dinar_2.png",
        "/Users/artur/AndroidStudioProjects/OneEntry/sdk-storage/src/commonTest/resources/dinar_3.png"
    ]
    
    init() async throws {
        let config = try TestConfig.load()
        
        OneEntryApp.shared.initialize(
            host: config.host,
            token: config.token
        ) {
            LogLevel(.all)
        }
        
        self.storage = try await StorageService.shared.upload(
            id: 3787,
            type: "page",
            entity: "entity"
        ) {
            for path in paths {
                File(path: path)
            }
        }
    }
        
    @Test
    @available(iOS 16.0, *)
    func content() async throws {
        for file in storage {
            let filename = try #require(file.filename().split(separator: "-").first)
            let path = try #require(paths.first { $0.contains(filename) })
            let local = try Data(contentsOf: URL(filePath: path))
            let remote = try await StorageService.shared.content(
                filename: file.filename(),
                id: 3787,
                type: "page",
                entity: "entity"
            )
            
            #expect(local == remote)
        }
    }
    
    @Test
    func removing() async throws {
        for file in storage {
            try await StorageService.shared.delete(
                filename: file.filename(),
                id: 3787,
                type: "page",
                entity: "entity"
            )
        }
    }
}
