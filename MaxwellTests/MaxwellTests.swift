import Foundation
import Testing
@testable import Maxwell

@MainActor
struct MaxwellTests {
    private func makeStore() throws -> MaxwellDataStore {
        let database = try AppDatabase.makeInMemory()
        return MaxwellDataStore(dbWriter: database)
    }

    @Test func greetingWithName() {
        #expect(GreetingBuilder.greeting(name: "Max") == "Hello, Max!")
    }

    @Test func greetingWithWhitespaceReturnsDefault() {
        #expect(GreetingBuilder.greeting(name: "   \n\t") == "Hello!")
    }

    @Test func createAndFetchFloorPlan() throws {
        let store = try makeStore()
        let plan = try store.createFloorPlan(name: "Home")

        let plans = try store.fetchFloorPlans()
        #expect(plans.count == 1)
        #expect(plans.first?.id == plan.id)
        #expect(plans.first?.name == "Home")
    }

    @Test func deleteFloorPlanRemovesRecord() throws {
        let store = try makeStore()
        let plan = try store.createFloorPlan(name: "Home")

        try store.deleteFloorPlan(id: plan.id)
        #expect(try store.fetchFloorPlans().isEmpty)
    }

    @Test func createAndFetchFloorsSortedByOrder() throws {
        let store = try makeStore()
        let plan = try store.createFloorPlan(name: "Home")

        _ = try store.createFloor(floorPlanId: plan.id, name: "Second", orderIndex: 1)
        _ = try store.createFloor(floorPlanId: plan.id, name: "First", orderIndex: 0)

        let floors = try store.fetchFloors(floorPlanId: plan.id)
        #expect(floors.map(\.orderIndex) == [0, 1])
        #expect(floors.map(\.name) == ["First", "Second"])
    }

    @Test func deleteFloorRemovesRecord() throws {
        let store = try makeStore()
        let plan = try store.createFloorPlan(name: "Home")
        let floor = try store.createFloor(floorPlanId: plan.id, name: "Main", orderIndex: 0)

        try store.deleteFloor(id: floor.id)
        #expect(try store.fetchFloors(floorPlanId: plan.id).isEmpty)
    }

    @Test func createAndFetchRoomsSortedByOrder() throws {
        let store = try makeStore()
        let plan = try store.createFloorPlan(name: "Home")
        let floor = try store.createFloor(floorPlanId: plan.id, name: "Main", orderIndex: 0)

        _ = try store.createRoom(floorId: floor.id, name: "Kitchen", orderIndex: 1)
        _ = try store.createRoom(floorId: floor.id, name: "Living", orderIndex: 0)

        let rooms = try store.fetchRooms(floorId: floor.id)
        #expect(rooms.map(\.orderIndex) == [0, 1])
        #expect(rooms.map(\.name) == ["Living", "Kitchen"])
    }

    @Test func deleteRoomRemovesRecord() throws {
        let store = try makeStore()
        let plan = try store.createFloorPlan(name: "Home")
        let floor = try store.createFloor(floorPlanId: plan.id, name: "Main", orderIndex: 0)
        let room = try store.createRoom(floorId: floor.id, name: "Kitchen", orderIndex: 0)

        try store.deleteRoom(id: room.id)
        #expect(try store.fetchRooms(floorId: floor.id).isEmpty)
    }

    @Test func createAndFetchShapes() throws {
        let store = try makeStore()
        let plan = try store.createFloorPlan(name: "Home")
        let floor = try store.createFloor(floorPlanId: plan.id, name: "Main", orderIndex: 0)
        let room = try store.createRoom(floorId: floor.id, name: "Kitchen", orderIndex: 0)

        _ = try store.createShape(
            roomId: room.id,
            shapeType: .rectangle,
            sizeWidth: 3,
            sizeHeight: 4,
            localPositionX: 1,
            localPositionY: 2
        )

        let shapes = try store.fetchShapes(roomId: room.id)
        #expect(shapes.count == 1)
        #expect(shapes.first?.shapeType == .rectangle)
    }

    @Test func deleteShapeRemovesRecord() throws {
        let store = try makeStore()
        let plan = try store.createFloorPlan(name: "Home")
        let floor = try store.createFloor(floorPlanId: plan.id, name: "Main", orderIndex: 0)
        let room = try store.createRoom(floorId: floor.id, name: "Kitchen", orderIndex: 0)
        let shape = try store.createShape(
            roomId: room.id,
            shapeType: .rectangle,
            sizeWidth: 3,
            sizeHeight: 4,
            localPositionX: 1,
            localPositionY: 2
        )

        try store.deleteShape(id: shape.id)
        #expect(try store.fetchShapes(roomId: room.id).isEmpty)
    }

    @Test func createAndFetchBulbs() throws {
        let store = try makeStore()
        let plan = try store.createFloorPlan(name: "Home")
        let floor = try store.createFloor(floorPlanId: plan.id, name: "Main", orderIndex: 0)
        let room = try store.createRoom(floorId: floor.id, name: "Kitchen", orderIndex: 0)

        _ = try store.createBulb(roomId: room.id, name: "Ceiling", bulbTypeId: "type-1")

        let bulbs = try store.fetchBulbs(roomId: room.id)
        #expect(bulbs.count == 1)
        #expect(bulbs.first?.name == "Ceiling")
        #expect(bulbs.first?.isWorking == true)
    }

    @Test func deleteBulbRemovesRecord() throws {
        let store = try makeStore()
        let plan = try store.createFloorPlan(name: "Home")
        let floor = try store.createFloor(floorPlanId: plan.id, name: "Main", orderIndex: 0)
        let room = try store.createRoom(floorId: floor.id, name: "Kitchen", orderIndex: 0)
        let bulb = try store.createBulb(roomId: room.id, name: "Ceiling", bulbTypeId: "type-1")

        try store.deleteBulb(id: bulb.id)
        #expect(try store.fetchBulbs(roomId: room.id).isEmpty)
    }

    @Test func createAndFetchBulbPlacements() throws {
        let store = try makeStore()
        let plan = try store.createFloorPlan(name: "Home")
        let floor = try store.createFloor(floorPlanId: plan.id, name: "Main", orderIndex: 0)
        let room = try store.createRoom(floorId: floor.id, name: "Kitchen", orderIndex: 0)
        let bulb = try store.createBulb(roomId: room.id, name: "Ceiling", bulbTypeId: "type-1")

        _ = try store.createBulbPlacement(
            bulbId: bulb.id,
            roomId: room.id,
            positionX: 2,
            positionY: 3,
            orientationRadians: 0.5
        )

        let placements = try store.fetchBulbPlacements(roomId: room.id)
        #expect(placements.count == 1)
        #expect(placements.first?.bulbId == bulb.id)
        #expect(placements.first?.orientationRadians == 0.5)
    }

    @Test func deleteBulbPlacementRemovesRecord() throws {
        let store = try makeStore()
        let plan = try store.createFloorPlan(name: "Home")
        let floor = try store.createFloor(floorPlanId: plan.id, name: "Main", orderIndex: 0)
        let room = try store.createRoom(floorId: floor.id, name: "Kitchen", orderIndex: 0)
        let bulb = try store.createBulb(roomId: room.id, name: "Ceiling", bulbTypeId: "type-1")
        let placement = try store.createBulbPlacement(bulbId: bulb.id, roomId: room.id, positionX: 2, positionY: 3)

        try store.deleteBulbPlacement(id: placement.id)
        #expect(try store.fetchBulbPlacements(roomId: room.id).isEmpty)
    }
}
