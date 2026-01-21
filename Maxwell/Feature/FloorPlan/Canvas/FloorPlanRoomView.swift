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
    @Bindable var viewModel: FloorPlanBuilderViewModel

    @GestureState private var dragTranslation: CGSize = .zero

    var body: some View {
        let adjustedTranslation = CGSize(
            width: dragTranslation.width / transformScale,
            height: dragTranslation.height / transformScale
        )
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
    }

    private func roomDragGesture(isOverlapping: Bool) -> some Gesture {
        DragGesture()
            .updating($dragTranslation) { value, state, _ in
                state = value.translation
            }
            .onEnded { value in
                let adjustedTranslation = CGSize(
                    width: value.translation.width / transformScale,
                    height: value.translation.height / transformScale
                )
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
}
