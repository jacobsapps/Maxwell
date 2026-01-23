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
    var fittingSize: String
    var colorId: String
    var isWorking: Bool
    var createdAt: Date

    init(
        id: UUID = UUID(),
        position: CGPoint,
        roomID: UUID,
        fittingSize: String,
        colorId: String,
        isWorking: Bool,
        createdAt: Date
    ) {
        self.id = id
        self.position = position
        self.roomID = roomID
        self.fittingSize = fittingSize
        self.colorId = colorId
        self.isWorking = isWorking
        self.createdAt = createdAt
    }
}
