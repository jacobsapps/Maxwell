//
//  FloorPlanResetViewButton.swift
//  Maxwell
//
//  Created by Codex on 22/01/2026.
//

import SwiftUI

struct FloorPlanResetViewButton: View {
    let controlsHidden: Bool
    let isEnabled: Bool
    let onReset: () -> Void

    @ScaledMetric(relativeTo: .body) private var panelWidth: CGFloat = 140
    @ScaledMetric(relativeTo: .body) private var segmentSize: CGFloat = 34

    var body: some View {
        FloorPlanIconButton(symbol: "arrow.counterclockwise", label: "Reset View", position: .single, size: segmentSize) {
            onReset()
        }
        .disabled(!isEnabled)
        .accessibilityIdentifier("FloorPlanResetViewButton")
        .frame(width: panelWidth)
        .offset(x: controlsHidden ? panelWidth + horizontalOffset : 0)
        .opacity(controlsHidden ? 0 : 1)
        .allowsHitTesting(!controlsHidden)
    }

    private var horizontalOffset: CGFloat {
        panelWidth * 0.6
    }
}
