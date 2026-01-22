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
    @Bindable var viewModel: FloorPlanBuilderViewModel

    @GestureState private var dragTranslation: CGSize = .zero
    @ScaledMetric(relativeTo: .body) private var bulbSize: CGFloat = 18

    var body: some View {
        let adjustedTranslation = CGSize(
            width: dragTranslation.width / transformScale,
            height: dragTranslation.height / transformScale
        )
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
    }

    private func bulbDragGesture() -> some Gesture {
        DragGesture()
            .updating($dragTranslation) { value, state, _ in
                state = value.translation
            }
            .onEnded { value in
                let adjustedTranslation = CGSize(
                    width: value.translation.width / transformScale,
                    height: value.translation.height / transformScale
                )
                let proposedPosition = CGPoint(
                    x: bulb.position.x + adjustedTranslation.width,
                    y: bulb.position.y + adjustedTranslation.height
                )
                guard let room = viewModel.roomContaining(point: proposedPosition) else { return }
                viewModel.moveBulb(id: bulb.id, position: proposedPosition, roomID: room.id)
            }
    }
}
