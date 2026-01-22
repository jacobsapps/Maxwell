//
//  FloorPlanRoomGeometryTests.swift
//  MaxwellTests
//
//  Created by Codex on 22/01/2026.
//

import Testing
import SwiftUI
@testable import Maxwell

struct FloorPlanRoomGeometryTests {
    @Test func rotatedRoomsOverlapWhenShapesIntersect() {
        let roomA = FloorPlanRoom(
            center: .zero,
            size: CGSize(width: 120, height: 40),
            rotation: Angle(degrees: 45)
        )
        let roomB = FloorPlanRoom(
            center: CGPoint(x: 20, y: 0),
            size: CGSize(width: 40, height: 40),
            rotation: .zero
        )

        #expect(roomA.overlaps(with: roomB) == true)
    }

    @Test func rotatedRoomsDoNotOverlapWhenSeparated() {
        let roomA = FloorPlanRoom(
            center: .zero,
            size: CGSize(width: 120, height: 40),
            rotation: Angle(degrees: 45)
        )
        let roomB = FloorPlanRoom(
            center: CGPoint(x: 140, y: 0),
            size: CGSize(width: 40, height: 40),
            rotation: .zero
        )

        #expect(roomA.overlaps(with: roomB) == false)
    }
}
