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
    private(set) var floors: [FloorPlanFloor]
    private(set) var selectedFloorID: UUID

    init() {
        let firstFloor = FloorPlanFloor(name: "Floor 1")
        self.floors = [firstFloor]
        self.selectedFloorID = firstFloor.id
    }

    var roomCount: Int {
        selectedFloor.rooms.count
    }

    var bulbCount: Int {
        selectedFloor.bulbs.count
    }

    var selectedFloor: FloorPlanFloor {
        guard let floor = floors.first(where: { $0.id == selectedFloorID }) else {
            return floors.first ?? FloorPlanFloor(name: "Floor 1")
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
        updateFloor(id: id) { floor in
            floor.name = trimmed
        }
    }

    func addRoom(center: CGPoint, size: CGSize, rotation: Angle) {
        updateSelectedFloor { floor in
            floor.rooms.append(FloorPlanRoom(center: center, size: size, rotation: rotation))
        }
    }

    func moveRoom(id: UUID, center: CGPoint) {
        updateSelectedFloor { floor in
            guard let index = floor.rooms.firstIndex(where: { $0.id == id }) else { return }
            floor.rooms[index].center = center
        }
    }

    func updateRoom(id: UUID, size: CGSize, rotation: Angle) {
        updateSelectedFloor { floor in
            guard let index = floor.rooms.firstIndex(where: { $0.id == id }) else { return }
            floor.rooms[index].size = size
            floor.rooms[index].rotation = rotation
        }
    }

    func addBulb(at position: CGPoint, roomID: UUID) {
        updateSelectedFloor { floor in
            floor.bulbs.append(FloorPlanBulb(position: position, roomID: roomID))
        }
    }

    func moveBulb(id: UUID, position: CGPoint, roomID: UUID) {
        updateSelectedFloor { floor in
            guard let index = floor.bulbs.firstIndex(where: { $0.id == id }) else { return }
            floor.bulbs[index].position = position
            floor.bulbs[index].roomID = roomID
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
        let name = "Floor \(floors.count + 1)"
        let floor = FloorPlanFloor(name: name)
        floors.insert(floor, at: newIndex)
        selectedFloorID = floor.id
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
}
