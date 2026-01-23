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
    @GestureState private var rotationDelta: Angle = .zero

    var body: some View {
        let adjustedTranslation = adjustedTranslation(for: dragTranslation)
        let proposedCenter = CGPoint(
            x: room.center.x + adjustedTranslation.width,
            y: room.center.y + adjustedTranslation.height
        )
        ZStack(alignment: .bottom) {
            FloorPlanRoomShapeView(room: room, isOverlapping: false)
            FloorPlanRoomNameView(
                room: room,
                isContentDragActive: $isContentDragActive,
                viewModel: viewModel
            )
        }
        .rotationEffect(room.rotation + rotationDelta)
        .position(x: center.x + proposedCenter.x, y: center.y + proposedCenter.y)
        .gesture(roomDragGesture())
        .simultaneousGesture(roomRotationGesture())
        .accessibilityLabel(Text("Room"))
        .accessibilityIdentifier("FloorPlanRoom")
    }

    private func roomDragGesture() -> some Gesture {
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
                viewModel.moveRoom(id: room.id, center: proposedCenter)
            }
    }

    private func roomRotationGesture() -> some Gesture {
        RotationGesture()
            .onChanged { _ in
                isContentDragActive = true
            }
            .updating($rotationDelta) { value, state, _ in
                state = value
            }
            .onEnded { value in
                isContentDragActive = false
                viewModel.updateRoom(id: room.id, size: room.size, rotation: room.rotation + value)
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
