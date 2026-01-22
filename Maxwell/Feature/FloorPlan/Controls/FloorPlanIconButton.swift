//
//  FloorPlanIconButton.swift
//  Maxwell
//
//  Created by Jacob Bartlett on 21/01/2026.
//

import SwiftUI

struct FloorPlanIconButton: View {
    let symbol: String
    let label: String
    let position: FloorPlanSegmentPosition
    let size: CGFloat
    let action: () -> Void

    var body: some View {
        FloorPlanSegmentButton(
            position: position,
            size: CGSize(width: size, height: size),
            isSelected: false,
            action: action
        ) {
            Label(label, systemImage: symbol)
                .labelStyle(.iconOnly)
                .font(.callout)
        }
    }
}
