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

    @Test @MainActor func addingFloorAboveSelectsNewFloor() {
        let viewModel = FloorPlanBuilderViewModel()
        let originalFloorID = viewModel.selectedFloorID

        viewModel.addFloorAbove()

        #expect(viewModel.floors.count == 2)
        #expect(viewModel.selectedFloorID != originalFloorID)
    }

    @Test @MainActor func renameFloorTrimsWhitespace() {
        let viewModel = FloorPlanBuilderViewModel()
        let floorID = viewModel.selectedFloorID

        viewModel.renameFloor(id: floorID, name: "  Kitchen  ")

        #expect(viewModel.selectedFloor.name == "Kitchen")
    }

    @Test @MainActor func overlapDetectionFindsIntersectingRooms() {
        let viewModel = FloorPlanBuilderViewModel()
        viewModel.addRoom(center: CGPoint(x: 0, y: 0), size: CGSize(width: 100, height: 100), rotation: .zero)

        let candidate = FloorPlanRoom(center: CGPoint(x: 10, y: 10), size: CGSize(width: 80, height: 80), rotation: .zero)

        #expect(viewModel.overlaps(candidate: candidate) == true)
    }
}
