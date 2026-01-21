import Foundation
import SQLiteData

enum AppDatabase {
    static func makeLive() throws -> DatabaseQueue {
        try makeDatabase(url: databaseURL())
    }

    static func makeInMemory() throws -> DatabaseQueue {
        try makeDatabase(url: nil)
    }

    private static func makeDatabase(url: URL?) throws -> DatabaseQueue {
        let queue: DatabaseQueue
        if let url {
            queue = try DatabaseQueue(path: url.path)
        } else {
            queue = try DatabaseQueue(path: ":memory:")
        }
        try migrator.migrate(queue)
        return queue
    }

    private static func databaseURL() throws -> URL {
        let directory = URL.documentsDirectory.appending(path: "Maxwell")
        try FileManager.default.createDirectory(
            at: directory,
            withIntermediateDirectories: true
        )
        return directory.appending(path: "maxwell.sqlite")
    }

    private static var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()

        migrator.registerMigration("createFloorPlans") { db in
            try db.create(table: "floor_plans") { t in
                t.column("id", .blob).primaryKey()
                t.column("name", .text).notNull()
            }
        }

        migrator.registerMigration("createFloors") { db in
            try db.create(table: "floors") { t in
                t.column("id", .blob).primaryKey()
                t.column("floorPlanId", .blob).notNull()
                t.column("name", .text).notNull()
                t.column("orderIndex", .integer).notNull()
            }
        }

        migrator.registerMigration("createRooms") { db in
            try db.create(table: "rooms") { t in
                t.column("id", .blob).primaryKey()
                t.column("floorId", .blob).notNull()
                t.column("name", .text).notNull()
                t.column("orderIndex", .integer).notNull()
                t.column("transformTranslationX", .double).notNull().defaults(to: 0)
                t.column("transformTranslationY", .double).notNull().defaults(to: 0)
                t.column("transformRotationRadians", .double).notNull().defaults(to: 0)
                t.column("transformScale", .double).notNull().defaults(to: 1)
            }
        }

        migrator.registerMigration("createShapes") { db in
            try db.create(table: "shapes") { t in
                t.column("id", .blob).primaryKey()
                t.column("roomId", .blob).notNull()
                t.column("shapeType", .text).notNull()
                t.column("sizeWidth", .double).notNull()
                t.column("sizeHeight", .double).notNull()
                t.column("localPositionX", .double).notNull()
                t.column("localPositionY", .double).notNull()
                t.column("localRotationRadians", .double).notNull().defaults(to: 0)
                t.column("localScale", .double).notNull().defaults(to: 1)
            }
        }

        migrator.registerMigration("createBulbs") { db in
            try db.create(table: "bulbs") { t in
                t.column("id", .blob).primaryKey()
                t.column("roomId", .blob).notNull()
                t.column("name", .text).notNull()
                t.column("bulbTypeId", .text).notNull()
                t.column("isWorking", .boolean).notNull().defaults(to: true)
                t.column("markedNotWorkingAt", .datetime)
            }
        }

        migrator.registerMigration("createBulbPlacements") { db in
            try db.create(table: "bulb_placements") { t in
                t.column("id", .blob).primaryKey()
                t.column("bulbId", .blob).notNull()
                t.column("roomId", .blob).notNull()
                t.column("positionX", .double).notNull()
                t.column("positionY", .double).notNull()
                t.column("orientationRadians", .double).notNull().defaults(to: 0)
                t.column("attachedShapeId", .blob)
            }
        }

        return migrator
    }
}
