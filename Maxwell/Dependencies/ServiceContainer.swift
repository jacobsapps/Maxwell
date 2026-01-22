import Factory
import Foundation
import SQLiteData

extension Container {
    var databaseWriter: Factory<any DatabaseWriter> {
        self {
            MainActor.assumeIsolated {
                do {
                    if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
                        return try AppDatabase.makeInMemory()
                    }
                    return try AppDatabase.makeLive()
                } catch {
                    fatalError("Failed to open Maxwell database: \(error)")
                }
            }
        }
        .singleton
    }

    var maxwellDataStore: Factory<MaxwellDataStore> {
        self {
            MainActor.assumeIsolated {
                MaxwellDataStore(dbWriter: self.databaseWriter())
            }
        }
        .singleton
    }
}
