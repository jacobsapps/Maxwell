//
//  CGPoint+Geometry.swift
//  Maxwell
//
//  Created by Codex on 22/01/2026.
//

import CoreGraphics

extension CGPoint {
    func rotated(by radians: Double) -> CGPoint {
        let cosine = CGFloat(cos(radians))
        let sine = CGFloat(sin(radians))
        return CGPoint(
            x: x * cosine - y * sine,
            y: x * sine + y * cosine
        )
    }

    func dot(_ other: CGPoint) -> CGFloat {
        x * other.x + y * other.y
    }
}
