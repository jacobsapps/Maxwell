//
//  FloorPlanRoomShapeView.swift
//  Maxwell
//
//  Created by Jacob Bartlett on 21/01/2026.
//

import SwiftUI

struct FloorPlanRoomShapeView: View {
    let room: FloorPlanRoom
    let isOverlapping: Bool

    @ScaledMetric(relativeTo: .body) private var cornerRadius: CGFloat = BulbMetrics.cornerRadius

    var body: some View {
        let strokeGradient = LinearGradient(
            colors: [Color.cct2400, Color.cct3000, Color.cct4500],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        let strokeStyle = isOverlapping
            ? AnyShapeStyle(strokeGradient)
            : AnyShapeStyle(Color.bulbEdge.opacity(0.6))

        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(Color.bulbSurface)
            .frame(width: room.size.width, height: room.size.height)
            .overlay {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder(strokeStyle, lineWidth: isOverlapping ? 3 : 1)
                    .shadow(
                        color: isOverlapping ? Color.bulbGlow : .clear,
                        radius: isOverlapping ? BulbMetrics.glowRadius : 0
                    )
            }
    }
}
