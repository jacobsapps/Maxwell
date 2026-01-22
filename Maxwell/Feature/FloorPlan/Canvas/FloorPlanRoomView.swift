//
//  FloorPlanRoomView.swift
//  Maxwell
//
//  Created by Jacob Bartlett on 21/01/2026.
//

import SwiftUI

struct FloorPlanRoomView: View {
    let room: FloorPlanRoom
    let center: CGPoint
    let transformScale: CGFloat
    let transformRotation: Angle
    @Binding var isContentDragActive: Bool
    @Bindable var viewModel: FloorPlanBuilderViewModel

    @GestureState private var dragTranslation: CGSize = .zero

    var body: some View {
        let adjustedTranslation = adjustedTranslation(for: dragTranslation)
        let proposedCenter = CGPoint(
            x: room.center.x + adjustedTranslation.width,
            y: room.center.y + adjustedTranslation.height
        )
        let candidate = FloorPlanRoom(
            id: room.id,
            center: proposedCenter,
            size: room.size,
            rotation: room.rotation
        )
        let isOverlapping = viewModel.overlaps(candidate: candidate, excluding: room.id)

        FloorPlanRoomShapeView(room: room, isOverlapping: isOverlapping)
            .rotationEffect(room.rotation)
            .position(x: center.x + proposedCenter.x, y: center.y + proposedCenter.y)
            .gesture(roomDragGesture(isOverlapping: isOverlapping))
            .accessibilityLabel(Text("Room"))
            .accessibilityIdentifier("FloorPlanRoom")
    }

    private func roomDragGesture(isOverlapping: Bool) -> some Gesture {
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
                let proposedCenter = CGPoint(
                    x: room.center.x + adjustedTranslation.width,
                    y: room.center.y + adjustedTranslation.height
                )
                let candidate = FloorPlanRoom(
                    id: room.id,
                    center: proposedCenter,
                    size: room.size,
                    rotation: room.rotation
                )
                guard viewModel.overlaps(candidate: candidate, excluding: room.id) == false else {
                    return
                }
                viewModel.moveRoom(id: room.id, center: proposedCenter)
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
