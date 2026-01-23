//
//  SummaryViewModelTests.swift
//  MaxwellTests
//
//  Created by Codex on 22/01/2026.
//

import Testing
import SwiftUI
@testable import Maxwell

struct SummaryViewModelTests {
    private func makeBulb(position: CGPoint, roomID: UUID) -> FloorPlanBulb {
        FloorPlanBulb(
            position: position,
            roomID: roomID,
            fittingSize: Bulb.defaultFittingSize,
            colorId: Bulb.defaultColorId,
            isWorking: true,
            createdAt: Date()
        )
    }

    @Test func floorSubtitlePluralization() {
        let room = FloorPlanRoom(center: .zero, size: CGSize(width: 10, height: 10), rotation: .zero)
        let bulb = makeBulb(position: .zero, roomID: room.id)
        let floor = FloorPlanFloor(name: "Floor 1", rooms: [room], bulbs: [bulb])
        let viewModel = SummaryViewModel(floors: [floor])

        #expect(viewModel.floorSubtitle(for: floor) == "1 Room | 1 Bulb")
    }

    @Test func bulbsFilterByRoom() {
        let roomA = FloorPlanRoom(center: .zero, size: CGSize(width: 10, height: 10), rotation: .zero)
        let roomB = FloorPlanRoom(center: CGPoint(x: 20, y: 20), size: CGSize(width: 10, height: 10), rotation: .zero)
        let bulbs: [FloorPlanBulb] = [
            makeBulb(position: .zero, roomID: roomA.id),
            makeBulb(position: CGPoint(x: 5, y: 5), roomID: roomA.id),
            makeBulb(position: CGPoint(x: 2, y: 2), roomID: roomB.id)
        ]
        let floor = FloorPlanFloor(name: "Floor 1", rooms: [roomA, roomB], bulbs: bulbs)
        let viewModel = SummaryViewModel(floors: [floor])

        let filtered = viewModel.bulbs(for: roomA, in: floor)

        #expect(filtered.count == 2)
        #expect(filtered.allSatisfy { $0.roomID == roomA.id })
    }

    @Test func titleHelpersIncrementFromOne() {
        let viewModel = SummaryViewModel(floors: [])

        #expect(viewModel.roomTitle(for: 0) == "Room 1")
        #expect(viewModel.bulbTitle(for: 2) == "Bulb 3")
    }
}
