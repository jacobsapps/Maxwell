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
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(.regularMaterial)
            .frame(width: room.size.width, height: room.size.height)
            .overlay {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder(isOverlapping ? Color.accentColor : Color.secondary, lineWidth: isOverlapping ? 3 : 1)
            }
    }
}
