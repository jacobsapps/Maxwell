//
//  FloorPlanBulb.swift
//  Maxwell
//
//  Created by Jacob Bartlett on 21/01/2026.
//

import Foundation

struct FloorPlanBulb: Identifiable {
    let id: UUID
    var position: CGPoint
    var roomID: UUID

    init(id: UUID = UUID(), position: CGPoint, roomID: UUID) {
        self.id = id
        self.position = position
        self.roomID = roomID
    }
}
