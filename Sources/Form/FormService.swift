//
//  FormService.swift
//  OneEntry
//
//  Created by Archibbald on 12/24/24.
//

import Foundation

@preconcurrency import OneEntryShared
import OneEntryCore

public extension FormsService {
    @discardableResult
    func sendData(
        formIdentifier: String,
        replayTo: Int? = nil,
        formModuleConfigId: Int,
        moduleEntityIdentifier: String,
        status: String? = nil,
        isolation: isolated (any Actor)? = #isolation,
        @DSLBuilder<Locale> perform body: () -> [Locale]
    ) async throws -> FormDataSubmitting {
        let locales = body()
        
        return try await sendData(
            formIdentifier: formIdentifier,
            replayTo: replayTo.map { KotlinInt(int: Int32($0)) },
            formModuleConfigId: Int32(formModuleConfigId),
            moduleEntityIdentifier: moduleEntityIdentifier,
            status: status
        ) { builder in
            for locale in locales {
                builder.locale(langCode: locale.langCode) { builder in
                    for data in locale.data {
                        builder.put(data: data)
                    }
                }
            }
        }
    }
}
