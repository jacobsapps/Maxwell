//
//  FloorPlanBuilderViewModelTests.swift
//  MaxwellTests
//
//  Created by Jacob Bartlett on 21/01/2026.
//

import Testing
import SwiftUI
@testable import Maxwell

struct FloorPlanBuilderViewModelTests {
    @MainActor private func makeViewModel() throws -> FloorPlanBuilderViewModel {
        let database = try AppDatabase.makeInMemory()
        let store = MaxwellDataStore(dbWriter: database)
        return FloorPlanBuilderViewModel(store: store)
    }

    @Test @MainActor func addingFloorAboveSelectsNewFloor() throws {
        let viewModel = try makeViewModel()
        let originalFloorID = viewModel.selectedFloorID

        viewModel.addFloorAbove()

        #expect(viewModel.floors.count == 2)
        #expect(viewModel.selectedFloorID != originalFloorID)
    }

    @Test @MainActor func renameFloorTrimsWhitespace() throws {
        let viewModel = try makeViewModel()
        let floorID = viewModel.selectedFloorID

        viewModel.renameFloor(id: floorID, name: "  Kitchen  ")

        #expect(viewModel.selectedFloor.name == "Kitchen")
    }

    @Test @MainActor func overlapDetectionFindsIntersectingRooms() throws {
        let viewModel = try makeViewModel()
        viewModel.addRoom(center: CGPoint(x: 0, y: 0), size: CGSize(width: 100, height: 100), rotation: .zero)

        let candidate = FloorPlanRoom(center: CGPoint(x: 10, y: 10), size: CGSize(width: 80, height: 80), rotation: .zero)

        #expect(viewModel.overlaps(candidate: candidate) == true)
    }

    @Test @MainActor func rotatedRoomContainmentUsesRoomRotation() throws {
        let viewModel = try makeViewModel()
        let rotation = Angle(degrees: 45)
        viewModel.addRoom(center: .zero, size: CGSize(width: 100, height: 60), rotation: rotation)

        let insideLocal = CGPoint(x: 20, y: 0)
        let insideGlobal = insideLocal.rotated(by: rotation.radians)
        #expect(viewModel.roomContaining(point: insideGlobal) != nil)

        let outsideLocal = CGPoint(x: 60, y: 0)
        let outsideGlobal = outsideLocal.rotated(by: rotation.radians)
        #expect(viewModel.roomContaining(point: outsideGlobal) == nil)
    }
}
