//
//  SummaryViewModel.swift
//  Maxwell
//
//  Created by Codex on 22/01/2026.
//

import Foundation

struct SummaryViewModel {
    let floors: [FloorPlanFloor]

    init(floors: [FloorPlanFloor]) {
        self.floors = floors
    }

    func floorSubtitle(for floor: FloorPlanFloor) -> String {
        let roomCount = floor.rooms.count
        let bulbCount = floor.bulbs.count
        return "\(roomCount) \(pluralized(roomCount, singular: "Room")) | \(bulbCount) \(pluralized(bulbCount, singular: "Bulb"))"
    }

    func roomTitle(for room: FloorPlanRoom, index: Int) -> String {
        let trimmed = room.name.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty ? "Room \(index + 1)" : trimmed
    }

    func bulbTitle(for index: Int) -> String {
        "Bulb \(index + 1)"
    }

    func bulbs(for room: FloorPlanRoom, in floor: FloorPlanFloor) -> [FloorPlanBulb] {
        floor.bulbs.filter { $0.roomID == room.id }
    }

    private func pluralized(_ count: Int, singular: String) -> String {
        count == 1 ? singular : "\(singular)s"
    }
}
