import Foundation
import SQLiteData

@MainActor
struct MaxwellDataStore {
    let dbWriter: any DatabaseWriter

    init(dbWriter: any DatabaseWriter) {
        self.dbWriter = dbWriter
    }

    func createFloorPlan(name: String) throws -> FloorPlan {
        let floorPlan = FloorPlan(name: name)
        try dbWriter.write { db in
            try FloorPlan.insert { floorPlan }.execute(db)
        }
        return floorPlan
    }

    func fetchFloorPlans() throws -> [FloorPlan] {
        try dbWriter.read { db in
            try FloorPlan.all.fetchAll(db)
        }
    }

    func deleteFloorPlan(id: UUID) throws {
        try dbWriter.write { db in
            try FloorPlan.find(id).delete().execute(db)
        }
    }

    func createFloor(floorPlanId: UUID, name: String, orderIndex: Int) throws -> Floor {
        let floor = Floor(floorPlanId: floorPlanId, name: name, orderIndex: orderIndex)
        try dbWriter.write { db in
            try Floor.insert { floor }.execute(db)
        }
        return floor
    }

    func fetchFloors(floorPlanId: UUID) throws -> [Floor] {
        try dbWriter.read { db in
            try Floor.all
                .where { $0.floorPlanId == floorPlanId }
                .order(by: \.orderIndex)
                .fetchAll(db)
        }
    }

    func deleteFloor(id: UUID) throws {
        try dbWriter.write { db in
            try Floor.find(id).delete().execute(db)
        }
    }

    func createRoom(
        floorId: UUID,
        name: String,
        orderIndex: Int,
        transformTranslationX: Double = 0,
        transformTranslationY: Double = 0,
        transformRotationRadians: Double = 0,
        transformScale: Double = 1
    ) throws -> Room {
        let room = Room(
            floorId: floorId,
            name: name,
            orderIndex: orderIndex,
            transformTranslationX: transformTranslationX,
            transformTranslationY: transformTranslationY,
            transformRotationRadians: transformRotationRadians,
            transformScale: transformScale
        )
        try dbWriter.write { db in
            try Room.insert { room }.execute(db)
        }
        return room
    }

    func fetchRooms(floorId: UUID) throws -> [Room] {
        try dbWriter.read { db in
            try Room.all
                .where { $0.floorId == floorId }
                .order(by: \.orderIndex)
                .fetchAll(db)
        }
    }

    func deleteRoom(id: UUID) throws {
        try dbWriter.write { db in
            try Room.find(id).delete().execute(db)
        }
    }

    func createShape(
        roomId: UUID,
        shapeType: ShapeType,
        sizeWidth: Double,
        sizeHeight: Double,
        localPositionX: Double,
        localPositionY: Double,
        localRotationRadians: Double = 0,
        localScale: Double = 1
    ) throws -> Shape {
        let shape = Shape(
            roomId: roomId,
            shapeType: shapeType,
            sizeWidth: sizeWidth,
            sizeHeight: sizeHeight,
            localPositionX: localPositionX,
            localPositionY: localPositionY,
            localRotationRadians: localRotationRadians,
            localScale: localScale
        )
        try dbWriter.write { db in
            try Shape.insert { shape }.execute(db)
        }
        return shape
    }

    func fetchShapes(roomId: UUID) throws -> [Shape] {
        try dbWriter.read { db in
            try Shape.all
                .where { $0.roomId == roomId }
                .fetchAll(db)
        }
    }

    func deleteShape(id: UUID) throws {
        try dbWriter.write { db in
            try Shape.find(id).delete().execute(db)
        }
    }

    func createBulb(
        roomId: UUID,
        name: String,
        bulbTypeId: String,
        isWorking: Bool = true,
        markedNotWorkingAt: Date? = nil
    ) throws -> Bulb {
        let bulb = Bulb(
            roomId: roomId,
            name: name,
            bulbTypeId: bulbTypeId,
            isWorking: isWorking,
            markedNotWorkingAt: markedNotWorkingAt
        )
        try dbWriter.write { db in
            try Bulb.insert { bulb }.execute(db)
        }
        return bulb
    }

    func fetchBulbs(roomId: UUID) throws -> [Bulb] {
        try dbWriter.read { db in
            try Bulb.all
                .where { $0.roomId == roomId }
                .fetchAll(db)
        }
    }

    func deleteBulb(id: UUID) throws {
        try dbWriter.write { db in
            try Bulb.find(id).delete().execute(db)
        }
    }

    func createBulbPlacement(
        bulbId: UUID,
        roomId: UUID,
        positionX: Double,
        positionY: Double,
        orientationRadians: Double = 0,
        attachedShapeId: UUID? = nil
    ) throws -> BulbPlacement {
        let placement = BulbPlacement(
            bulbId: bulbId,
            roomId: roomId,
            positionX: positionX,
            positionY: positionY,
            orientationRadians: orientationRadians,
            attachedShapeId: attachedShapeId
        )
        try dbWriter.write { db in
            try BulbPlacement.insert { placement }.execute(db)
        }
        return placement
    }

    func fetchBulbPlacements(roomId: UUID) throws -> [BulbPlacement] {
        try dbWriter.read { db in
            try BulbPlacement.all
                .where { $0.roomId == roomId }
                .fetchAll(db)
        }
    }

    func deleteBulbPlacement(id: UUID) throws {
        try dbWriter.write { db in
            try BulbPlacement.find(id).delete().execute(db)
        }
    }
}
