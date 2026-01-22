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
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity)
        }
        .padding(BulbSpacing.xs)
        .background(isSelected ? Color.bulbGlow : .clear, in: .rect(cornerRadius: BulbMetrics.smallCornerRadius))
        .floorPlanGlassButtonStyle()
    }
}
