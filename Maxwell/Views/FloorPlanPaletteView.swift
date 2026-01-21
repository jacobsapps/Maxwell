//
//  FloorPlanPaletteView.swift
//  Maxwell
//
//  Created by Jacob Bartlett on 21/01/2026.
//

import SwiftUI

struct FloorPlanPaletteView: View {
    let controlsHidden: Bool
    let onSelect: (FloorPlanPaletteItem) -> Void

    @ScaledMetric(relativeTo: .body) private var panelWidth: CGFloat = 120
    @ScaledMetric(relativeTo: .body) private var itemSpacing: CGFloat = 12

    var body: some View {
        FloorPlanGlassPanel(cornerRadius: 20) {
            VStack(spacing: itemSpacing) {
                ForEach(FloorPlanPaletteItem.allCases) { item in
                    FloorPlanPaletteItemButton(item: item) {
                        onSelect(item)
                    }
                }
            }
            .frame(width: panelWidth)
        }
        .offset(x: controlsHidden ? panelWidth + horizontalOffset : 0)
        .opacity(controlsHidden ? 0 : 1)
        .allowsHitTesting(!controlsHidden)
    }

    private var horizontalOffset: CGFloat {
        panelWidth * 0.6
    }
}
