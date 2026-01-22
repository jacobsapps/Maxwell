//
//  FloorPlanBulbView.swift
//  Maxwell
//
//  Created by Jacob Bartlett on 21/01/2026.
//

import SwiftUI

struct FloorPlanBulbView: View {
    let bulb: FloorPlanBulb
    let center: CGPoint
    let transformScale: CGFloat
    let transformRotation: Angle
    @Binding var isContentDragActive: Bool
    @Bindable var viewModel: FloorPlanBuilderViewModel

    @GestureState private var dragTranslation: CGSize = .zero
    @ScaledMetric(relativeTo: .body) private var bulbSize: CGFloat = 18

    var body: some View {
        let adjustedTranslation = adjustedTranslation(for: dragTranslation)
        let proposedPosition = CGPoint(
            x: bulb.position.x + adjustedTranslation.width,
            y: bulb.position.y + adjustedTranslation.height
        )

        Circle()
            .fill(Color.bulbWarm)
            .frame(width: bulbSize, height: bulbSize)
            .overlay {
                Circle()
                    .strokeBorder(Color.bulbEdge.opacity(0.7), lineWidth: 2)
            }
            .shadow(color: Color.bulbGlow, radius: BulbMetrics.glowRadius / 2, x: 0, y: 4)
            .position(x: center.x + proposedPosition.x, y: center.y + proposedPosition.y)
            .gesture(bulbDragGesture())
            .accessibilityLabel(Text("Bulb"))
            .accessibilityIdentifier("FloorPlanBulb")
    }

    private func bulbDragGesture() -> some Gesture {
        DragGesture()
            .onChanged { _ in
                isContentDragActive = true
            }
            .updating($dragTranslation) { value, state, _ in
                state = value.translation
            }
            .onEnded { value in
                isContentDragActive = false
                let adjustedTranslation = adjustedTranslation(for: value.translation)
                let proposedPosition = CGPoint(
                    x: bulb.position.x + adjustedTranslation.width,
                    y: bulb.position.y + adjustedTranslation.height
                )
                guard let room = viewModel.roomContaining(point: proposedPosition) else { return }
                viewModel.moveBulb(id: bulb.id, position: proposedPosition, roomID: room.id)
            }
    }

    private func adjustedTranslation(for translation: CGSize) -> CGSize {
        let scaled = CGPoint(
            x: translation.width / transformScale,
            y: translation.height / transformScale
        )
        let rotated = scaled.rotated(by: -transformRotation.radians)
        return CGSize(width: rotated.x, height: rotated.y)
    }
}
