//
//  FloorPlanControlsOverlayView.swift
//  Maxwell
//
//  Created by Jacob Bartlett on 21/01/2026.
//

import SwiftUI

struct FloorPlanControlsOverlayView: View {
    @Bindable var viewModel: FloorPlanBuilderViewModel
    @Binding var placementState: FloorPlanPlacementState?
    @Binding var canvasTransform: FloorPlanCanvasTransform
    @Binding var isPaletteDragActive: Bool
    let canvasMetrics: FloorPlanCanvasMetrics

    @ScaledMetric(relativeTo: .body) private var horizontalPadding: CGFloat = BulbSpacing.lg
    @ScaledMetric(relativeTo: .body) private var glassSpacing: CGFloat = BulbSpacing.xl

    var body: some View {
        let controlsHidden = placementState != nil && isPaletteDragActive == false

        Group {
            if #available(iOS 26, *) {
                GlassEffectContainer(spacing: glassSpacing) {
                    controlsBody(controlsHidden: controlsHidden)
                }
            } else {
                controlsBody(controlsHidden: controlsHidden)
            }
        }
        .padding(.horizontal, horizontalPadding)
        .animation(.snappy, value: controlsHidden)
    }

    @ViewBuilder
    private func controlsBody(controlsHidden: Bool) -> some View {
        HStack {
            FloorPlanFloorSelectorView(viewModel: viewModel, controlsHidden: controlsHidden)
            Spacer(minLength: 0)
            VStack(spacing: glassSpacing) {
                FloorPlanResetViewButton(
                    controlsHidden: controlsHidden,
                    isEnabled: canvasTransform.isIdentity == false
                ) {
                    withAnimation(.snappy) {
                        canvasTransform = .identity
                    }
                }

                FloorPlanPaletteView(
                    controlsHidden: controlsHidden,
                    onDragChanged: handlePaletteDragChanged,
                    onDragEnded: handlePaletteDragEnded
                )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func handlePaletteDragChanged(item: FloorPlanPaletteItem, location: CGPoint) {
        guard canvasMetrics.size != .zero else { return }
        isPaletteDragActive = true
        let canvasLocation = canvasTransform.canvasPoint(from: location, center: canvasMetrics.center)
        var placement = placementState
        if placement?.item != item {
            placement = FloorPlanPlacementState(item: item)
        }
        if placement == nil {
            placement = FloorPlanPlacementState(item: item)
        }
        guard var updatedPlacement = placement else { return }
        updatedPlacement.item = item
        updatedPlacement.location = canvasLocation
        updatedPlacement.isOverlapping = false
        placementState = updatedPlacement
    }

    private func handlePaletteDragEnded(item: FloorPlanPaletteItem, location: CGPoint) {
        defer { isPaletteDragActive = false }
        guard canvasMetrics.size != .zero else { return }
        guard var placement = placementState else { return }
        placement.location = canvasTransform.canvasPoint(from: location, center: canvasMetrics.center)
        placement.isOverlapping = false
        commitPlacement(placement)
    }

    private func commitPlacement(_ placement: FloorPlanPlacementState) {
        defer { placementState = nil }
        guard let location = placement.location else { return }
        switch placement.item {
        case .room:
            viewModel.addRoom(center: location, size: placement.size, rotation: placement.rotation)
        case .bulb:
            guard let room = viewModel.roomContaining(point: location) else { return }
            viewModel.addBulb(at: location, roomID: room.id)
        }
    }
}
