//
//  FloorPlanCanvasView.swift
//  Maxwell
//
//  Created by Jacob Bartlett on 21/01/2026.
//

import SwiftUI

struct FloorPlanCanvasView: View {
    @Bindable var viewModel: FloorPlanBuilderViewModel
    @Binding var placementState: FloorPlanPlacementState?
    @Binding var canvasTransform: FloorPlanCanvasTransform
    let canvasMetrics: FloorPlanCanvasMetrics

    @State private var isContentDragActive = false

    @GestureState private var panTranslation: CGSize = .zero
    @GestureState private var zoomScale: CGFloat = 1
    @GestureState private var rotationDelta: Angle = .zero

    @State private var placementBaseSize: CGSize?
    @State private var placementBaseRotation: Angle?

    var body: some View {
        let center = canvasMetrics.center
        let transformScale = canvasTransform.scale * zoomScale
        let transformRotation = canvasTransform.rotation + rotationDelta
        let transformOffset = CGSize(
            width: canvasTransform.offset.width + panTranslation.width,
            height: canvasTransform.offset.height + panTranslation.height
        )

        ZStack {
            FloorPlanCanvasBackgroundView()

            FloorPlanRoomLayerView(
                rooms: viewModel.selectedFloor.rooms,
                bulbs: viewModel.selectedFloor.bulbs,
                center: center,
                transformScale: transformScale,
                transformRotation: transformRotation,
                transformOffset: transformOffset,
                isPlacementActive: placementState != nil,
                isContentDragActive: $isContentDragActive,
                viewModel: viewModel
            )

            if let placement = placementState {
                FloorPlanPlacementView(
                    placement: placement,
                    center: center,
                    transformScale: transformScale,
                    transformRotation: transformRotation,
                    transformOffset: transformOffset
                )
            }
        }
        .contentShape(.rect)
        .accessibilityIdentifier("FloorPlanCanvas")
        .onChange(of: placementState) { _, newValue in
            if newValue == nil {
                placementBaseSize = nil
                placementBaseRotation = nil
            }
        }
        .simultaneousGesture(panGesture())
        .simultaneousGesture(zoomGesture())
        .simultaneousGesture(rotationGesture())
    }

    private func panGesture() -> some Gesture {
        DragGesture()
            .updating($panTranslation) { value, state, _ in
                guard placementState == nil, isContentDragActive == false else { return }
                state = value.translation
            }
            .onEnded { value in
                guard placementState == nil, isContentDragActive == false else { return }
                canvasTransform.offset = CGSize(
                    width: canvasTransform.offset.width + value.translation.width,
                    height: canvasTransform.offset.height + value.translation.height
                )
            }
    }

    private func zoomGesture() -> some Gesture {
        MagnificationGesture()
            .onChanged { value in
                guard var placement = placementState, placement.item == .room else { return }
                if placementBaseSize == nil {
                    placementBaseSize = placement.size
                }
                if let baseSize = placementBaseSize {
                    placement.size = CGSize(width: baseSize.width * value, height: baseSize.height * value)
                    placementState = placement
                }
            }
            .updating($zoomScale) { value, state, _ in
                guard placementState == nil, isContentDragActive == false else { return }
                state = value
            }
            .onEnded { value in
                if placementState == nil {
                    guard isContentDragActive == false else { return }
                    canvasTransform.scale = max(0.2, min(canvasTransform.scale * value, 4))
                    return
                }
                guard var placement = placementState, placement.item == .room else { return }
                let baseSize = placementBaseSize ?? placement.size
                placement.size = CGSize(width: baseSize.width * value, height: baseSize.height * value)
                placementState = placement
                placementBaseSize = nil
            }
    }

    private func rotationGesture() -> some Gesture {
        RotationGesture()
            .onChanged { value in
                guard var placement = placementState, placement.item == .room else { return }
                if placementBaseRotation == nil {
                    placementBaseRotation = placement.rotation
                }
                if let baseRotation = placementBaseRotation {
                    placement.rotation = baseRotation + value
                    placementState = placement
                }
            }
            .updating($rotationDelta) { value, state, _ in
                guard placementState == nil, isContentDragActive == false else { return }
                state = value
            }
            .onEnded { value in
                if placementState == nil {
                    guard isContentDragActive == false else { return }
                    canvasTransform.rotation += value
                    return
                }
                guard var placement = placementState, placement.item == .room else { return }
                let baseRotation = placementBaseRotation ?? placement.rotation
                placement.rotation = baseRotation + value
                placementState = placement
                placementBaseRotation = nil
            }
    }

}
