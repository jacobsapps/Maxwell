//
//  FloorPlanBuilderView.swift
//  Maxwell
//
//  Created by Jacob Bartlett on 21/01/2026.
//

import SwiftUI

struct FloorPlanBuilderView: View {
    @Bindable var viewModel: FloorPlanBuilderViewModel

    @State private var placementState: FloorPlanPlacementState?
    @State private var canvasTransform = FloorPlanCanvasTransform()
    @State private var isPaletteDragActive = false

    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                let canvasMetrics = FloorPlanCanvasMetrics(
                    center: CGPoint(x: proxy.size.width / 2, y: proxy.size.height / 2),
                    size: proxy.size
                )

                ZStack {
                    FloorPlanCanvasView(
                        viewModel: viewModel,
                        placementState: $placementState,
                        canvasTransform: $canvasTransform,
                        canvasMetrics: canvasMetrics
                    )

                    FloorPlanControlsOverlayView(
                        viewModel: viewModel,
                        placementState: $placementState,
                        canvasTransform: $canvasTransform,
                        isPaletteDragActive: $isPaletteDragActive,
                        canvasMetrics: canvasMetrics
                    )
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .coordinateSpace(name: FloorPlanCanvasCoordinateSpace.name)
            }
            .navigationTitle("Floor Plan")
        }
    }
}
