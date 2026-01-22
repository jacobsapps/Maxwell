//
//  FloorPlanFloorButton.swift
//  Maxwell
//
//  Created by Jacob Bartlett on 21/01/2026.
//

import SwiftUI

struct FloorPlanFloorButton: View {
    let title: String
    let isSelected: Bool
    let position: FloorPlanSegmentPosition
    let size: CGFloat
    let action: () -> Void

    var body: some View {
        FloorPlanGlassSegmentButton(
            position: position,
            size: CGSize(width: size, height: size),
            isSelected: isSelected,
            action: action
        ) {
            Text(title)
                .font(.caption)
                .bold()
        }
    }
}
