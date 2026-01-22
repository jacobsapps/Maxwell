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
    @State private var canvasMetrics = FloorPlanCanvasMetrics.zero
    @State private var isPaletteDragActive = false

    var body: some View {
        NavigationStack {
            ZStack {
                FloorPlanCanvasView(
                    viewModel: viewModel,
                    placementState: $placementState,
                    canvasTransform: $canvasTransform
                )
                .ignoresSafeArea()
                .onPreferenceChange(FloorPlanCanvasMetricsKey.self) { metrics in
                    canvasMetrics = metrics
                }

                FloorPlanControlsOverlayView(
                    viewModel: viewModel,
                    placementState: $placementState,
                    canvasTransform: $canvasTransform,
                    isPaletteDragActive: $isPaletteDragActive,
                    canvasMetrics: canvasMetrics
                )
            }
            .navigationTitle("Floor Plan")
        }
    }
}
