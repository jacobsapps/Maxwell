//
//  FloorPlanSegmentButton.swift
//  Maxwell
//
//  Created by Codex on 22/01/2026.
//

import SwiftUI

enum FloorPlanSegmentPosition {
    case single
    case top
    case middle
    case bottom
}

struct FloorPlanSegmentButton<Label: View>: View {
    let position: FloorPlanSegmentPosition
    let size: CGSize
    let isSelected: Bool
    let action: () -> Void
    @ViewBuilder let label: () -> Label

    var body: some View {
        if isSelected {
            Button(action: action) {
                label()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.small)
            .frame(width: size.width, height: size.height)
        } else {
            Button(action: action) {
                label()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .buttonStyle(.bordered)
            .controlSize(.small)
            .frame(width: size.width, height: size.height)
        }
    }
}
