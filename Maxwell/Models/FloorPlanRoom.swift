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

    func contains(point: CGPoint) -> Bool {
        let translated = CGPoint(x: point.x - center.x, y: point.y - center.y)
        let local = translated.rotated(by: -rotation.radians)
        let halfWidth = size.width / 2
        let halfHeight = size.height / 2
        return abs(local.x) <= halfWidth && abs(local.y) <= halfHeight
    }

    func overlaps(with other: FloorPlanRoom) -> Bool {
        let axes = [axisX, axisY, other.axisX, other.axisY]
        let corners = rotatedCorners()
        let otherCorners = other.rotatedCorners()

        for axis in axes {
            let range = projectedRange(points: corners, axis: axis)
            let otherRange = projectedRange(points: otherCorners, axis: axis)
            if range.max < otherRange.min || otherRange.max < range.min {
                return false
            }
        }
        return true
    }

    private var axisX: CGPoint {
        let radians = rotation.radians
        return CGPoint(x: CGFloat(cos(radians)), y: CGFloat(sin(radians)))
    }

    private var axisY: CGPoint {
        let radians = rotation.radians
        return CGPoint(x: CGFloat(-sin(radians)), y: CGFloat(cos(radians)))
    }

    private func rotatedCorners() -> [CGPoint] {
        let halfWidth = size.width / 2
        let halfHeight = size.height / 2
        let localCorners = [
            CGPoint(x: -halfWidth, y: -halfHeight),
            CGPoint(x: halfWidth, y: -halfHeight),
            CGPoint(x: halfWidth, y: halfHeight),
            CGPoint(x: -halfWidth, y: halfHeight)
        ]

        return localCorners.map { local in
            let rotated = local.rotated(by: rotation.radians)
            return CGPoint(x: center.x + rotated.x, y: center.y + rotated.y)
        }
    }

    private func projectedRange(points: [CGPoint], axis: CGPoint) -> (min: CGFloat, max: CGFloat) {
        let projections = points.map { $0.dot(axis) }
        guard let minProjection = projections.min(), let maxProjection = projections.max() else {
            return (0, 0)
        }
        return (minProjection, maxProjection)
    }
}
