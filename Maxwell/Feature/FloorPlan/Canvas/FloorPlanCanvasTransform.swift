//
//  FloorPlanCanvasTransform.swift
//  Maxwell
//
//  Created by Codex on 22/01/2026.
//

import SwiftUI

struct FloorPlanCanvasTransform: Equatable {
    var scale: CGFloat = 1
    var rotation: Angle = .zero
    var offset: CGSize = .zero

    static let identity = FloorPlanCanvasTransform()

    var isIdentity: Bool {
        self == Self.identity
    }

    func canvasPoint(from viewPoint: CGPoint, center: CGPoint) -> CGPoint {
        let translatedX = viewPoint.x - center.x - offset.width
        let translatedY = viewPoint.y - center.y - offset.height
        let translated = CGPoint(x: translatedX, y: translatedY)
        let rotated = translated.rotated(by: -rotation.radians)
        return CGPoint(x: rotated.x / scale, y: rotated.y / scale)
    }
}
