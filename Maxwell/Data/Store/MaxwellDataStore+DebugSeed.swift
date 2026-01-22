//
//  MaxwellDataStore+DebugSeed.swift
//  Maxwell
//
//  Created by Codex on 22/01/2026.
//

import Foundation
import SwiftUI

#if DEBUG
enum DebugArguments {
    static let seedSummary = "MAXWELL_SEED_SUMMARY"
}

@MainActor
extension MaxwellDataStore {
    static var shouldSeedSummary: Bool {
        ProcessInfo.processInfo.arguments.contains(DebugArguments.seedSummary)
    }

    func seedSummary(floorPlanId: UUID) throws {
        struct SeedRoom {
            let name: String
            let bulbs: Int
        }

        struct SeedFloor {
            let name: String
            let rooms: [SeedRoom]
        }

        let seedFloors: [SeedFloor] = [
            SeedFloor(name: "Ground", rooms: [
                SeedRoom(name: "Entry", bulbs: 1),
                SeedRoom(name: "Living", bulbs: 3),
                SeedRoom(name: "Kitchen", bulbs: 2)
            ]),
            SeedFloor(name: "Basement", rooms: [
                SeedRoom(name: "Laundry", bulbs: 1),
                SeedRoom(name: "Workshop", bulbs: 2),
                SeedRoom(name: "Storage", bulbs: 1)
            ]),
            SeedFloor(name: "One Floor", rooms: [
                SeedRoom(name: "Bedroom", bulbs: 2),
                SeedRoom(name: "Office", bulbs: 1),
                SeedRoom(name: "Bath", bulbs: 1)
            ]),
            SeedFloor(name: "One Floor Two", rooms: [
                SeedRoom(name: "Guest", bulbs: 1),
                SeedRoom(name: "Media", bulbs: 2)
            ])
        ]

        let roomSize = FloorPlanPaletteItem.room.defaultSize
        let roomSpacing = CGSize(width: roomSize.width + 60, height: roomSize.height + 60)
        let origin = CGPoint(x: 160, y: 160)
        let bulbPositions: [CGPoint] = [
            CGPoint(x: 0, y: 0),
            CGPoint(x: 40, y: -30),
            CGPoint(x: -40, y: 30),
            CGPoint(x: 60, y: 40)
        ]

        for (floorIndex, seedFloor) in seedFloors.enumerated() {
            let floor = try createFloor(
                floorPlanId: floorPlanId,
                name: seedFloor.name,
                orderIndex: floorIndex
            )

            for (roomIndex, seedRoom) in seedFloor.rooms.enumerated() {
                let column = roomIndex % 2
                let row = roomIndex / 2
                let center = CGPoint(
                    x: origin.x + CGFloat(column) * roomSpacing.width,
                    y: origin.y + CGFloat(row) * roomSpacing.height
                )
                let room = try createRoom(
                    floorId: floor.id,
                    name: seedRoom.name,
                    orderIndex: roomIndex,
                    transformTranslationX: Double(center.x),
                    transformTranslationY: Double(center.y),
                    transformRotationRadians: 0,
                    transformScale: 1
                )
                _ = try createShape(
                    roomId: room.id,
                    shapeType: .rectangle,
                    sizeWidth: Double(roomSize.width),
                    sizeHeight: Double(roomSize.height),
                    localPositionX: 0,
                    localPositionY: 0
                )

                for bulbIndex in 0..<seedRoom.bulbs {
                    let bulb = try createBulb(
                        roomId: room.id,
                        name: "Bulb \(bulbIndex + 1)",
                        bulbTypeId: "default"
                    )
                    let localPosition = bulbPositions[bulbIndex % bulbPositions.count]
                    _ = try createBulbPlacement(
                        bulbId: bulb.id,
                        roomId: room.id,
                        positionX: Double(localPosition.x),
                        positionY: Double(localPosition.y)
                    )
                }
            }
        }
    }
}
#endif
