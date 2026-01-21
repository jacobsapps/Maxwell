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

    @ScaledMetric(relativeTo: .body) private var cornerRadius: CGFloat = 16

    var body: some View {
        let strokeGradient = LinearGradient(
            colors: [Color.orange, Color.pink, Color.purple],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        let strokeStyle = isOverlapping
            ? AnyShapeStyle(strokeGradient)
            : AnyShapeStyle(Color.secondary.opacity(0.4))

        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(Color.accentColor.opacity(0.12))
            .frame(width: room.size.width, height: room.size.height)
            .overlay {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder(strokeStyle, lineWidth: isOverlapping ? 3 : 1)
                    .shadow(
                        color: isOverlapping ? Color.orange.opacity(0.4) : .clear,
                        radius: isOverlapping ? 10 : 0
                    )
            }
    }
}
