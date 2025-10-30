import Testing
import OneEntryCore
import OneEntryShared
import OneEntryFoundationTests

struct CoreTests {
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
    func test404() async throws {
        do {
            try await print(SystemService.shared.test404())
        } catch let error as NSError {
            let exception = try #require(error.kotlinException as? OneEntryException.NotFoundException)
            
            #expect(exception.statusCode == 404)
        }
    }
    
    @Test
    func test500() async throws {
        do {
            try await print(SystemService.shared.test500())
        } catch let error as NSError {
            let exception = try #require(error.kotlinException as? OneEntryException.InternalServerException)
            
            #expect(exception.statusCode == 500)
        }
    }
}
