//
//  FloorPlanPaletteView.swift
//  Maxwell
//
//  Created by Jacob Bartlett on 21/01/2026.
//

import SwiftUI

struct FloorPlanPaletteView: View {
    let controlsHidden: Bool
    let onDragChanged: (FloorPlanPaletteItem, CGPoint) -> Void
    let onDragEnded: (FloorPlanPaletteItem, CGPoint) -> Void

    @ScaledMetric(relativeTo: .body) private var panelWidth: CGFloat = 60
    @ScaledMetric(relativeTo: .body) private var itemHeight: CGFloat = 70

    var body: some View {
        let items = FloorPlanPaletteItem.allCases

        VStack(spacing: 0) {
            ForEach(items.enumerated(), id: \.element.id) { index, item in
                FloorPlanPaletteItemButton(
                    item: item,
                    position: segmentPosition(for: index, count: items.count),
                    size: CGSize(width: panelWidth, height: itemHeight),
                    onDragChanged: onDragChanged,
                    onDragEnded: onDragEnded
                )
            }
        }
        .frame(width: panelWidth, height: totalHeight(for: items.count), alignment: .top)
        .offset(x: controlsHidden ? panelWidth + horizontalOffset : 0)
        .opacity(controlsHidden ? 0 : 1)
        .allowsHitTesting(!controlsHidden)
    }

    private func segmentPosition(for index: Int, count: Int) -> FloorPlanSegmentPosition {
        guard count > 1 else { return .single }
        if index == 0 {
            return .top
        }
        if index == count - 1 {
            return .bottom
        }
        return .middle
    }

    private func totalHeight(for count: Int) -> CGFloat {
        itemHeight * CGFloat(count)
    }

    private var horizontalOffset: CGFloat {
        panelWidth * 1.2
    }
}
