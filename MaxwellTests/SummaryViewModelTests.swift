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

    @Test func floorSubtitlePluralization() {
        let room = FloorPlanRoom(name: "Room 1", center: .zero, size: CGSize(width: 10, height: 10), rotation: .zero)
        let bulb = FloorPlanBulb(position: .zero, roomID: room.id)
        let floor = FloorPlanFloor(name: "Floor 1", rooms: [room], bulbs: [bulb])
        let viewModel = SummaryViewModel(floors: [floor])

        #expect(viewModel.floorSubtitle(for: floor) == "1 Room | 1 Bulb")
    }

    @Test func bulbsFilterByRoom() {
        let roomA = FloorPlanRoom(name: "Room A", center: .zero, size: CGSize(width: 10, height: 10), rotation: .zero)
        let roomB = FloorPlanRoom(name: "Room B", center: CGPoint(x: 20, y: 20), size: CGSize(width: 10, height: 10), rotation: .zero)
        let bulbs: [FloorPlanBulb] = [
            FloorPlanBulb(position: .zero, roomID: roomA.id),
            FloorPlanBulb(position: CGPoint(x: 5, y: 5), roomID: roomA.id),
            FloorPlanBulb(position: CGPoint(x: 2, y: 2), roomID: roomB.id)
        ]
        let floor = FloorPlanFloor(name: "Floor 1", rooms: [roomA, roomB], bulbs: bulbs)
        let viewModel = SummaryViewModel(floors: [floor])

        let filtered = viewModel.bulbs(for: roomA, in: floor)

        #expect(filtered.count == 2)
        #expect(filtered.allSatisfy { $0.roomID == roomA.id })
    }

    @Test func titleHelpersIncrementFromOne() {
        let viewModel = SummaryViewModel(floors: [])

        #expect(viewModel.bulbTitle(for: 2) == "Bulb 3")
    }

    @Test func roomTitleUsesRoomName() {
        let viewModel = SummaryViewModel(floors: [])
        let room = FloorPlanRoom(name: "Kitchen", center: .zero, size: CGSize(width: 10, height: 10), rotation: .zero)

        #expect(viewModel.roomTitle(for: room, index: 0) == "Kitchen")
    }

    @Test func roomTitleFallsBackWhenEmpty() {
        let viewModel = SummaryViewModel(floors: [])
        let room = FloorPlanRoom(name: "   ", center: .zero, size: CGSize(width: 10, height: 10), rotation: .zero)

        #expect(viewModel.roomTitle(for: room, index: 1) == "Room 2")
    }
}
