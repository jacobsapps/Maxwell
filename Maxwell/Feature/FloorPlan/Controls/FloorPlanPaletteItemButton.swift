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
    let onDragChanged: (FloorPlanPaletteItem, CGPoint) -> Void
    let onDragEnded: (FloorPlanPaletteItem, CGPoint) -> Void

    var body: some View {
        FloorPlanSegment(position: position, size: size, isSelected: false) {
            Label(item.title, systemImage: item.systemImage)
                .labelStyle(FloorPlanVerticalLabelStyle())
        }
        .gesture(
            DragGesture(minimumDistance: 0, coordinateSpace: .named(FloorPlanCanvasCoordinateSpace.name))
                .onChanged { value in
                    onDragChanged(item, value.location)
                }
                .onEnded { value in
                    onDragEnded(item, value.location)
                }
        )
    }
}

private struct FloorPlanVerticalLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(spacing: BulbSpacing.xs) {
            configuration.icon
                .font(.title3)
            configuration.title
                .font(.caption)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
