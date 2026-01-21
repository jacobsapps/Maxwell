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

    @State private var canvasScale: CGFloat = 1
    @State private var canvasRotation: Angle = .zero
    @State private var canvasOffset: CGSize = .zero

    @GestureState private var panTranslation: CGSize = .zero
    @GestureState private var zoomScale: CGFloat = 1
    @GestureState private var rotationDelta: Angle = .zero

    @State private var placementBaseSize: CGSize?
    @State private var placementBaseRotation: Angle?

    var body: some View {
        GeometryReader { proxy in
            let center = CGPoint(x: proxy.size.width / 2, y: proxy.size.height / 2)
            let transformScale = canvasScale * zoomScale
            let transformRotation = canvasRotation + rotationDelta
            let transformOffset = CGSize(
                width: canvasOffset.width + panTranslation.width,
                height: canvasOffset.height + panTranslation.height
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
            .coordinateSpace(name: "FloorPlanCanvas")
            .contentShape(.rect)
            .onChange(of: placementState) { _, newValue in
                if newValue == nil {
                    placementBaseSize = nil
                    placementBaseRotation = nil
                }
            }
            .simultaneousGesture(panGesture())
            .simultaneousGesture(zoomGesture())
            .simultaneousGesture(rotationGesture())
            .simultaneousGesture(placementGesture(center: center, transformScale: transformScale, transformOffset: transformOffset))
        }
    }

    private func panGesture() -> some Gesture {
        DragGesture()
            .updating($panTranslation) { value, state, _ in
                guard placementState == nil else { return }
                state = value.translation
            }
            .onEnded { value in
                guard placementState == nil else { return }
                canvasOffset = CGSize(
                    width: canvasOffset.width + value.translation.width,
                    height: canvasOffset.height + value.translation.height
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
                    updatePlacementOverlap(&placement)
                    placementState = placement
                }
            }
            .updating($zoomScale) { value, state, _ in
                guard placementState == nil else { return }
                state = value
            }
            .onEnded { value in
                if placementState == nil {
                    canvasScale = max(0.2, min(canvasScale * value, 4))
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
                    updatePlacementOverlap(&placement)
                    placementState = placement
                }
            }
            .updating($rotationDelta) { value, state, _ in
                guard placementState == nil else { return }
                state = value
            }
            .onEnded { value in
                if placementState == nil {
                    canvasRotation += value
                    return
                }
                guard var placement = placementState, placement.item == .room else { return }
                let baseRotation = placementBaseRotation ?? placement.rotation
                placement.rotation = baseRotation + value
                placementState = placement
                placementBaseRotation = nil
            }
    }

    private func placementGesture(
        center: CGPoint,
        transformScale: CGFloat,
        transformOffset: CGSize
    ) -> some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { value in
                guard var placement = placementState else { return }
                let location = canvasPoint(from: value.location, center: center, transformScale: transformScale, transformOffset: transformOffset)
                placement.location = location
                updatePlacementOverlap(&placement)
                placementState = placement
            }
            .onEnded { value in
                guard var placement = placementState else { return }
                let location = canvasPoint(from: value.location, center: center, transformScale: transformScale, transformOffset: transformOffset)
                placement.location = location
                commitPlacement(placement)
            }
    }

    private func canvasPoint(
        from viewPoint: CGPoint,
        center: CGPoint,
        transformScale: CGFloat,
        transformOffset: CGSize
    ) -> CGPoint {
        let translatedX = viewPoint.x - center.x - transformOffset.width
        let translatedY = viewPoint.y - center.y - transformOffset.height
        let scaledX = translatedX / transformScale
        let scaledY = translatedY / transformScale
        return CGPoint(x: scaledX, y: scaledY)
    }

    private func commitPlacement(_ placement: FloorPlanPlacementState) {
        defer {
            placementState = nil
            placementBaseSize = nil
            placementBaseRotation = nil
        }
        guard let location = placement.location else { return }
        switch placement.item {
        case .room:
            let candidate = FloorPlanRoom(center: location, size: placement.size, rotation: placement.rotation)
            guard viewModel.overlaps(candidate: candidate) == false else {
                return
            }
            viewModel.addRoom(center: location, size: placement.size, rotation: placement.rotation)
        case .bulb:
            guard let room = viewModel.roomContaining(point: location) else { return }
            viewModel.addBulb(at: location, roomID: room.id)
        }
    }

    private func updatePlacementOverlap(_ placement: inout FloorPlanPlacementState) {
        guard placement.item == .room else { return }
        guard let location = placement.location else { return }
        let candidate = FloorPlanRoom(center: location, size: placement.size, rotation: placement.rotation)
        placement.isOverlapping = viewModel.overlaps(candidate: candidate)
    }
}
