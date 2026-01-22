//
//  FloorPlanGlassSegment.swift
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

struct FloorPlanGlassSegmentButton<Label: View>: View {
    let position: FloorPlanSegmentPosition
    let size: CGSize
    let isSelected: Bool
    let action: () -> Void
    @ViewBuilder let label: () -> Label

    @ScaledMetric(relativeTo: .body) private var cornerRadius: CGFloat = BulbMetrics.smallCornerRadius

    var body: some View {
        Button(action: action) {
            label()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .buttonStyle(
            FloorPlanGlassSegmentButtonStyle(
                position: position,
                cornerRadius: cornerRadius,
                isSelected: isSelected
            )
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

private struct FloorPlanGlassSegmentButtonStyle: ButtonStyle {
    let position: FloorPlanSegmentPosition
    let cornerRadius: CGFloat
    let isSelected: Bool

    func makeBody(configuration: Configuration) -> some View {
        let radii = FloorPlanSegmentCornerRadii.forPosition(position, radius: cornerRadius)
        let shape = UnevenRoundedRectangle(
            topLeadingRadius: radii.topLeading,
            bottomLeadingRadius: radii.bottomLeading,
            bottomTrailingRadius: radii.bottomTrailing,
            topTrailingRadius: radii.topTrailing,
            style: .continuous
        )

        return configuration.label
            .foregroundStyle(Color.bulbInk)
            .contentShape(shape)
            .background(
                FloorPlanGlassSegmentBackground(
                    position: position,
                    cornerRadius: cornerRadius,
                    isSelected: isSelected
                )
            )
            .scaleEffect(configuration.isPressed ? 0.96 : 1)
            .animation(.easeOut(duration: 0.12), value: configuration.isPressed)
    }
}

private struct FloorPlanGlassSegmentBackground: View {
    let position: FloorPlanSegmentPosition
    let cornerRadius: CGFloat
    let isSelected: Bool

    var body: some View {
        let radii = FloorPlanSegmentCornerRadii.forPosition(position, radius: cornerRadius)
        let shape = UnevenRoundedRectangle(
            topLeadingRadius: radii.topLeading,
            bottomLeadingRadius: radii.bottomLeading,
            bottomTrailingRadius: radii.bottomTrailing,
            topTrailingRadius: radii.topTrailing,
            style: .continuous
        )

        Color.clear
            .background(Color.bulbSurface, in: shape)
        .overlay(
            Group {
                if isSelected {
                    shape.stroke(Color.bulbGlow.opacity(0.6), lineWidth: 1)
                }
            }
        )
        .overlay(
            shape.stroke(Color.bulbEdge.opacity(0.7), lineWidth: 1)
        )
        .clipShape(shape)
    }
}
