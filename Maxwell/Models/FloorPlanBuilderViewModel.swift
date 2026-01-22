//
//  FloorPlanBuilderViewModel.swift
//  Maxwell
//
//  Created by Jacob Bartlett on 21/01/2026.
//

import Observation
import SwiftUI

@MainActor
@Observable
final class FloorPlanBuilderViewModel {
    private struct LoadedState {
        let floorPlanID: UUID
        let floors: [FloorPlanFloor]
        let selectedFloorID: UUID
        let roomShapeIDs: [UUID: UUID]
        let bulbPlacementIDs: [UUID: UUID]
    }

    private let store: MaxwellDataStore
    private(set) var floorPlanID: UUID
    private(set) var floors: [FloorPlanFloor]
    private(set) var selectedFloorID: UUID
    private var roomShapeIDs: [UUID: UUID]
    private var bulbPlacementIDs: [UUID: UUID]

    private let defaultBulbTypeId = "default"

    init(store: MaxwellDataStore) {
        self.store = store
        do {
            let state = try Self.loadState(store: store)
            self.floorPlanID = state.floorPlanID
            self.floors = state.floors
            self.selectedFloorID = state.selectedFloorID
            self.roomShapeIDs = state.roomShapeIDs
            self.bulbPlacementIDs = state.bulbPlacementIDs
        } catch {
            let fallbackFloor = FloorPlanFloor(name: "G")
            self.floorPlanID = UUID()
            self.floors = [fallbackFloor]
            self.selectedFloorID = fallbackFloor.id
            self.roomShapeIDs = [:]
            self.bulbPlacementIDs = [:]
            assertionFailure("Failed to load floor plan state: \(error)")
        }
    }

    var roomCount: Int {
        selectedFloor.rooms.count
    }

    var bulbCount: Int {
        selectedFloor.bulbs.count
    }

    var selectedFloor: FloorPlanFloor {
        guard let floor = floors.first(where: { $0.id == selectedFloorID }) else {
            return floors.first ?? FloorPlanFloor(name: "G")
        }
        return floor
    }

    var selectedFloorIndex: Int {
        floors.firstIndex(where: { $0.id == selectedFloorID }) ?? 0
    }

    func selectFloor(id: UUID) {
        guard floors.contains(where: { $0.id == id }) else { return }
        selectedFloorID = id
    }

    func addFloorAbove() {
        insertFloor(at: 0)
    }

    func addFloorBelow() {
        insertFloor(at: floors.count)
    }

    func renameFloor(id: UUID, name: String) {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard trimmed.isEmpty == false else { return }
        do {
            try store.updateFloorName(id: id, name: trimmed)
            updateFloor(id: id) { floor in
                floor.name = trimmed
            }
        } catch {
            assertionFailure("Failed to rename floor: \(error)")
        }
    }

    func addRoom(center: CGPoint, size: CGSize, rotation: Angle) {
        do {
            let roomName = defaultRoomName(for: selectedFloor.rooms.count)
            let room = try store.createRoom(
                floorId: selectedFloorID,
                name: roomName,
                orderIndex: selectedFloor.rooms.count,
                transformTranslationX: Double(center.x),
                transformTranslationY: Double(center.y),
                transformRotationRadians: rotation.radians,
                transformScale: 1
            )
            let shape = try store.createShape(
                roomId: room.id,
                shapeType: .rectangle,
                sizeWidth: Double(size.width),
                sizeHeight: Double(size.height),
                localPositionX: 0,
                localPositionY: 0
            )
            roomShapeIDs[room.id] = shape.id
            updateSelectedFloor { floor in
                floor.rooms.append(FloorPlanRoom(id: room.id, center: center, size: size, rotation: rotation))
            }
        } catch {
            assertionFailure("Failed to add room: \(error)")
        }
    }

    func moveRoom(id: UUID, center: CGPoint) {
        guard let room = selectedFloor.rooms.first(where: { $0.id == id }) else { return }
        let delta = CGSize(width: center.x - room.center.x, height: center.y - room.center.y)
        updateSelectedFloor { floor in
            guard let index = floor.rooms.firstIndex(where: { $0.id == id }) else { return }
            floor.rooms[index].center = center
            if delta != .zero {
                for bulbIndex in floor.bulbs.indices where floor.bulbs[bulbIndex].roomID == id {
                    floor.bulbs[bulbIndex].position = CGPoint(
                        x: floor.bulbs[bulbIndex].position.x + delta.width,
                        y: floor.bulbs[bulbIndex].position.y + delta.height
                    )
                }
            }
        }
        do {
            try store.updateRoomTransform(
                id: id,
                translationX: Double(center.x),
                translationY: Double(center.y),
                rotationRadians: room.rotation.radians,
                scale: 1
            )
        } catch {
            assertionFailure("Failed to move room: \(error)")
        }
    }

    func updateRoom(id: UUID, size: CGSize, rotation: Angle) {
        guard let room = selectedFloor.rooms.first(where: { $0.id == id }) else { return }
        updateSelectedFloor { floor in
            guard let index = floor.rooms.firstIndex(where: { $0.id == id }) else { return }
            if rotation != room.rotation {
                let center = room.center
                for bulbIndex in floor.bulbs.indices where floor.bulbs[bulbIndex].roomID == id {
                    let local = localPoint(from: floor.bulbs[bulbIndex].position, center: center, rotation: room.rotation)
                    floor.bulbs[bulbIndex].position = globalPoint(from: local, center: center, rotation: rotation)
                }
            }
            floor.rooms[index].size = size
            floor.rooms[index].rotation = rotation
        }
        do {
            try store.updateRoomTransform(
                id: id,
                translationX: Double(room.center.x),
                translationY: Double(room.center.y),
                rotationRadians: rotation.radians,
                scale: 1
            )
            if let shapeId = roomShapeIDs[id] {
                try store.updateShapeSize(id: shapeId, width: Double(size.width), height: Double(size.height))
            }
        } catch {
            assertionFailure("Failed to update room: \(error)")
        }
    }

    func addBulb(at position: CGPoint, roomID: UUID) {
        guard let room = selectedFloor.rooms.first(where: { $0.id == roomID }) else { return }
        let local = localPoint(from: position, center: room.center, rotation: room.rotation)
        do {
            let bulbName = defaultBulbName(for: selectedFloor.bulbs.count)
            let bulb = try store.createBulb(roomId: roomID, name: bulbName, bulbTypeId: defaultBulbTypeId)
            let placement = try store.createBulbPlacement(
                bulbId: bulb.id,
                roomId: roomID,
                positionX: Double(local.x),
                positionY: Double(local.y)
            )
            bulbPlacementIDs[bulb.id] = placement.id
            updateSelectedFloor { floor in
                floor.bulbs.append(FloorPlanBulb(id: bulb.id, position: position, roomID: roomID))
            }
        } catch {
            assertionFailure("Failed to add bulb: \(error)")
        }
    }

    func moveBulb(id: UUID, position: CGPoint, roomID: UUID) {
        guard let room = selectedFloor.rooms.first(where: { $0.id == roomID }) else { return }
        let local = localPoint(from: position, center: room.center, rotation: room.rotation)
        updateSelectedFloor { floor in
            guard let index = floor.bulbs.firstIndex(where: { $0.id == id }) else { return }
            floor.bulbs[index].position = position
            floor.bulbs[index].roomID = roomID
        }
        do {
            let placementId = try store.updateBulbAndPlacement(
                id: id,
                roomId: roomID,
                positionX: Double(local.x),
                positionY: Double(local.y)
            )
            bulbPlacementIDs[id] = placementId
        } catch {
            assertionFailure("Failed to move bulb: \(error)")
        }
    }

    func roomContaining(point: CGPoint) -> FloorPlanRoom? {
        selectedFloor.rooms.first(where: { $0.rect.contains(point) })
    }

    func overlaps(candidate: FloorPlanRoom, excluding roomID: UUID? = nil) -> Bool {
        selectedFloor.rooms.contains { room in
            if let roomID, room.id == roomID {
                return false
            }
            return room.rect.intersects(candidate.rect)
        }
    }

    private func insertFloor(at index: Int) {
        let newIndex = max(0, min(index, floors.count))
        let name = defaultFloorName(for: newIndex)
        do {
            let floor = try store.createFloor(floorPlanId: floorPlanID, name: name, orderIndex: newIndex)
            let floorModel = FloorPlanFloor(id: floor.id, name: floor.name)
            floors.insert(floorModel, at: newIndex)
            selectedFloorID = floorModel.id
            persistFloorOrder()
        } catch {
            assertionFailure("Failed to insert floor: \(error)")
        }
    }

    private func updateSelectedFloor(_ update: (inout FloorPlanFloor) -> Void) {
        let index = selectedFloorIndex
        guard floors.indices.contains(index) else { return }
        var floor = floors[index]
        update(&floor)
        floors[index] = floor
    }

    private func updateFloor(id: UUID, _ update: (inout FloorPlanFloor) -> Void) {
        guard let index = floors.firstIndex(where: { $0.id == id }) else { return }
        var floor = floors[index]
        update(&floor)
        floors[index] = floor
    }

    private func persistFloorOrder() {
        do {
            for (index, floor) in floors.enumerated() {
                try store.updateFloorOrderIndex(id: floor.id, orderIndex: index)
            }
        } catch {
            assertionFailure("Failed to persist floor order: \(error)")
        }
    }

    private func defaultFloorName(for index: Int) -> String {
        guard floors.isEmpty == false else { return "G" }
        let groundIndex = floors.firstIndex(where: { $0.name == "G" }) ?? 0
        if index <= groundIndex {
            let level = (groundIndex - index) + 1
            return "\(level)F"
        }
        let level = index - groundIndex
        return "\(level)B"
    }

    private func defaultRoomName(for index: Int) -> String {
        "Room \(index + 1)"
    }

    private func defaultBulbName(for index: Int) -> String {
        "Bulb \(index + 1)"
    }

    private static func loadState(store: MaxwellDataStore) throws -> LoadedState {
        let floorPlans = try store.fetchFloorPlans()
        let floorPlan: FloorPlan
        if let existingPlan = floorPlans.first {
            floorPlan = existingPlan
        } else {
            floorPlan = try store.createFloorPlan(name: "Home")
        }
        var floors = try store.fetchFloors(floorPlanId: floorPlan.id)
        if floors.isEmpty {
            floors = [try store.createFloor(floorPlanId: floorPlan.id, name: "G", orderIndex: 0)]
        }
        if floors.count == 1, floors[0].name == "Floor 1" {
            try store.updateFloorName(id: floors[0].id, name: "G")
            floors[0].name = "G"
        }

        var floorModels: [FloorPlanFloor] = []
        var roomShapeIDs: [UUID: UUID] = [:]
        var bulbPlacementIDs: [UUID: UUID] = [:]

        for floor in floors {
            let rooms = try store.fetchRooms(floorId: floor.id)
            var floorRooms: [FloorPlanRoom] = []
            var floorBulbs: [FloorPlanBulb] = []

            for room in rooms {
                let shapes = try store.fetchShapes(roomId: room.id)
                let shape: Shape
                if let existingShape = shapes.first {
                    shape = existingShape
                } else {
                    shape = try store.createShape(
                        roomId: room.id,
                        shapeType: .rectangle,
                        sizeWidth: Double(FloorPlanPaletteItem.room.defaultSize.width),
                        sizeHeight: Double(FloorPlanPaletteItem.room.defaultSize.height),
                        localPositionX: 0,
                        localPositionY: 0
                    )
                }
                roomShapeIDs[room.id] = shape.id

                let floorRoom = FloorPlanRoom(
                    id: room.id,
                    center: CGPoint(x: room.transformTranslationX, y: room.transformTranslationY),
                    size: CGSize(width: shape.sizeWidth, height: shape.sizeHeight),
                    rotation: Angle(radians: room.transformRotationRadians)
                )
                floorRooms.append(floorRoom)

                let bulbs = try store.fetchBulbs(roomId: room.id)
                let placements = try store.fetchBulbPlacements(roomId: room.id)
                let placementByBulbId = Dictionary(uniqueKeysWithValues: placements.map { ($0.bulbId, $0) })

                for bulb in bulbs {
                    guard let placement = placementByBulbId[bulb.id] else { continue }
                    let local = CGPoint(x: placement.positionX, y: placement.positionY)
                    let global = globalPoint(from: local, center: floorRoom.center, rotation: floorRoom.rotation)
                    floorBulbs.append(FloorPlanBulb(id: bulb.id, position: global, roomID: room.id))
                    bulbPlacementIDs[bulb.id] = placement.id
                }
            }

            floorModels.append(FloorPlanFloor(id: floor.id, name: floor.name, rooms: floorRooms, bulbs: floorBulbs))
        }

        let selectedFloorID = floorModels.first?.id ?? UUID()
        return LoadedState(
            floorPlanID: floorPlan.id,
            floors: floorModels,
            selectedFloorID: selectedFloorID,
            roomShapeIDs: roomShapeIDs,
            bulbPlacementIDs: bulbPlacementIDs
        )
    }

    private func localPoint(from global: CGPoint, center: CGPoint, rotation: Angle) -> CGPoint {
        let translated = CGPoint(x: global.x - center.x, y: global.y - center.y)
        return translated.rotated(by: -rotation.radians)
    }

    private static func globalPoint(from local: CGPoint, center: CGPoint, rotation: Angle) -> CGPoint {
        let rotated = local.rotated(by: rotation.radians)
        return CGPoint(x: center.x + rotated.x, y: center.y + rotated.y)
    }

    private func globalPoint(from local: CGPoint, center: CGPoint, rotation: Angle) -> CGPoint {
        Self.globalPoint(from: local, center: center, rotation: rotation)
    }
}

private extension CGPoint {
    func rotated(by radians: Double) -> CGPoint {
        let cosine = cos(radians)
        let sine = sin(radians)
        return CGPoint(
            x: x * cosine - y * sine,
            y: x * sine + y * cosine
        )
    }
}
