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

struct FloorPlanSegment<Content: View>: View {
    let position: FloorPlanSegmentPosition
    let size: CGSize
    let isSelected: Bool
    @ViewBuilder let content: () -> Content

    @ScaledMetric(relativeTo: .body) private var cornerRadius: CGFloat = BulbMetrics.smallCornerRadius

    var body: some View {
        let radii = FloorPlanSegmentCornerRadii.forPosition(position, radius: cornerRadius)
        let shape = UnevenRoundedRectangle(
            topLeadingRadius: radii.topLeading,
            bottomLeadingRadius: radii.bottomLeading,
            bottomTrailingRadius: radii.bottomTrailing,
            topTrailingRadius: radii.topTrailing,
            style: .continuous
        )

        content()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .foregroundStyle(.primary)
            .contentShape(shape)
            .background(.thinMaterial, in: shape)
            .overlay(
                shape.stroke(isSelected ? Color.accentColor : .secondary, lineWidth: isSelected ? 2 : 1)
            )
            .frame(width: size.width, height: size.height)
    }
}

private struct FloorPlanSegmentCornerRadii {
    let topLeading: CGFloat
    let topTrailing: CGFloat
    let bottomLeading: CGFloat
    let bottomTrailing: CGFloat

    static func forPosition(_ position: FloorPlanSegmentPosition, radius: CGFloat) -> Self {
        switch position {
        case .single:
            return Self(topLeading: radius, topTrailing: radius, bottomLeading: radius, bottomTrailing: radius)
        case .top:
            return Self(topLeading: radius, topTrailing: radius, bottomLeading: 0, bottomTrailing: 0)
        case .middle:
            return Self(topLeading: 0, topTrailing: 0, bottomLeading: 0, bottomTrailing: 0)
        case .bottom:
            return Self(topLeading: 0, topTrailing: 0, bottomLeading: radius, bottomTrailing: radius)
        }
    }
}
