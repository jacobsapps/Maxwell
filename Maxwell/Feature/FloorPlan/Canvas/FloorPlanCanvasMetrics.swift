//
//  FloorPlanCanvasMetrics.swift
//  Maxwell
//
//  Created by Jacob Bartlett on 22/01/2026.
//

import CoreGraphics

struct FloorPlanCanvasMetrics: Equatable {
    let center: CGPoint
    let size: CGSize

    static let zero = FloorPlanCanvasMetrics(center: .zero, size: .zero)
}
