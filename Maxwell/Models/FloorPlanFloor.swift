//
//  FloorPlanFloor.swift
//  Maxwell
//
//  Created by Jacob Bartlett on 21/01/2026.
//

import Foundation

struct FloorPlanFloor: Identifiable {
    let id: UUID
    var name: String
    var rooms: [FloorPlanRoom]
    var bulbs: [FloorPlanBulb]

    init(id: UUID = UUID(), name: String, rooms: [FloorPlanRoom] = [], bulbs: [FloorPlanBulb] = []) {
        self.id = id
        self.name = name
        self.rooms = rooms
        self.bulbs = bulbs
    }
}
