//
//  FloorPlanPlacementView.swift
//  Maxwell
//
//  Created by Jacob Bartlett on 21/01/2026.
//

import SwiftUI

struct FloorPlanPlacementView: View {
    let placement: FloorPlanPlacementState
    let center: CGPoint
    let transformScale: CGFloat
    let transformRotation: Angle
    let transformOffset: CGSize

    var body: some View {
        let location = placement.location ?? .zero
        let position = CGPoint(x: center.x + location.x, y: center.y + location.y)

        Group {
            switch placement.item {
            case .room:
                FloorPlanRoomShapeView(
                    room: FloorPlanRoom(center: .zero, size: placement.size, rotation: placement.rotation),
                    isOverlapping: placement.isOverlapping
                )
                .rotationEffect(placement.rotation)
                .position(position)
            case .bulb:
                Circle()
                    .fill(.yellow)
                    .frame(width: placement.size.width, height: placement.size.height)
                    .overlay {
                        Circle()
                            .strokeBorder(Color.orange.opacity(0.6), lineWidth: 2)
                    }
                    .position(position)
            }
        }
        .scaleEffect(transformScale)
        .rotationEffect(transformRotation)
        .offset(transformOffset)
    }
}
