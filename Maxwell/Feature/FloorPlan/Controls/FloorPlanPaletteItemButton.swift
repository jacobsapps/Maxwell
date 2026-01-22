//
//  FloorPlanPaletteItemButton.swift
//  Maxwell
//
//  Created by Jacob Bartlett on 21/01/2026.
//

import SwiftUI

struct FloorPlanPaletteItemButton: View {
    let item: FloorPlanPaletteItem
    let position: FloorPlanSegmentPosition
    let size: CGSize
    let action: () -> Void

    var body: some View {
        FloorPlanGlassSegmentButton(
            position: position,
            size: size,
            isSelected: false,
            action: action
        ) {
            Label(item.title, systemImage: item.systemImage)
                .labelStyle(.iconOnly)
                .font(.callout)
        }
    }
}
