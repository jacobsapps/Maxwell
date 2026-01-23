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
    @MainActor private func makeStore() throws -> MaxwellDataStore {
        let database = try AppDatabase.makeInMemory()
        return MaxwellDataStore(dbWriter: database)
    }

    @MainActor private func makeViewModel(store: MaxwellDataStore? = nil) throws -> FloorPlanBuilderViewModel {
        let store = try store ?? makeStore()
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

        let candidate = FloorPlanRoom(name: "Candidate", center: CGPoint(x: 10, y: 10), size: CGSize(width: 80, height: 80), rotation: .zero)

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

    @Test @MainActor func renameRoomTrimsWhitespace() throws {
        let viewModel = try makeViewModel()
        viewModel.addRoom(center: .zero, size: CGSize(width: 80, height: 60), rotation: .zero)

        let roomID = try #require(viewModel.selectedFloor.rooms.first?.id)
        viewModel.renameRoom(id: roomID, name: "  Living Room  ")

        let updatedName = viewModel.selectedFloor.rooms.first?.name
        #expect(updatedName == "Living Room")
    }

    @Test @MainActor func renameRoomRejectsEmptyName() throws {
        let viewModel = try makeViewModel()
        viewModel.addRoom(center: .zero, size: CGSize(width: 80, height: 60), rotation: .zero)

        let room = try #require(viewModel.selectedFloor.rooms.first)
        viewModel.renameRoom(id: room.id, name: "   ")

        let updatedName = viewModel.selectedFloor.rooms.first?.name
        #expect(updatedName == room.name)
    }

    @Test @MainActor func renameRoomPersistsToStore() throws {
        let store = try makeStore()
        let viewModel = try makeViewModel(store: store)
        viewModel.addRoom(center: .zero, size: CGSize(width: 80, height: 60), rotation: .zero)

        let roomID = try #require(viewModel.selectedFloor.rooms.first?.id)
        viewModel.renameRoom(id: roomID, name: "Office")

        let reloaded = try makeViewModel(store: store)
        let persistedName = reloaded.selectedFloor.rooms.first?.name
        #expect(persistedName == "Office")
    }

    @Test @MainActor func newBulbInheritsMostRecentRoomConfig() throws {
        let viewModel = try makeViewModel()
        viewModel.addRoom(center: .zero, size: CGSize(width: 100, height: 100), rotation: .zero)

        guard let room = viewModel.selectedFloor.rooms.first else {
            #expect(Bool(false))
            return
        }

        viewModel.addBulb(at: CGPoint(x: 0, y: 0), roomID: room.id)
        guard let firstBulb = viewModel.selectedFloor.bulbs.last else {
            #expect(Bool(false))
            return
        }

        viewModel.updateBulbFitting(id: firstBulb.id, fittingSize: "E27")
        viewModel.updateBulbColor(id: firstBulb.id, colorId: "cool-5000")

        viewModel.addBulb(at: CGPoint(x: 10, y: 10), roomID: room.id)
        guard let secondBulb = viewModel.selectedFloor.bulbs.last else {
            #expect(Bool(false))
            return
        }

        #expect(secondBulb.fittingSize == "E27")
        #expect(secondBulb.colorId == "cool-5000")

        viewModel.updateBulbFitting(id: secondBulb.id, fittingSize: "G9")
        viewModel.updateBulbColor(id: secondBulb.id, colorId: "warm-2700")

        viewModel.addBulb(at: CGPoint(x: 20, y: 20), roomID: room.id)
        guard let thirdBulb = viewModel.selectedFloor.bulbs.last else {
            #expect(Bool(false))
            return
        }

        #expect(thirdBulb.fittingSize == "G9")
        #expect(thirdBulb.colorId == "warm-2700")
    }
}
