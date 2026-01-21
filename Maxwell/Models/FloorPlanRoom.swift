//
//  FloorPlanRoom.swift
//  Maxwell
//
//  Created by Jacob Bartlett on 21/01/2026.
//

import Foundation
import SwiftUI

struct FloorPlanRoom: Identifiable {
    let id: UUID
    var center: CGPoint
    var size: CGSize
    var rotation: Angle

    init(id: UUID = UUID(), center: CGPoint, size: CGSize, rotation: Angle) {
        self.id = id
        self.center = center
        self.size = size
        self.rotation = rotation
    }

    var rect: CGRect {
        CGRect(
            x: center.x - size.width / 2,
            y: center.y - size.height / 2,
            width: size.width,
            height: size.height
        )
    }
}
