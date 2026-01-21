//
//  FloorPlanPlacementState.swift
//  Maxwell
//
//  Created by Jacob Bartlett on 21/01/2026.
//

import SwiftUI

struct FloorPlanPlacementState: Equatable {
    var item: FloorPlanPaletteItem
    var location: CGPoint?
    var size: CGSize
    var rotation: Angle
    var isOverlapping: Bool

    init(item: FloorPlanPaletteItem, location: CGPoint? = nil) {
        self.item = item
        self.location = location
        self.size = item.defaultSize
        self.rotation = .zero
        self.isOverlapping = false
    }
}
