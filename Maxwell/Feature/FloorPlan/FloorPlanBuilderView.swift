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

    var body: some View {
        NavigationStack {
            ZStack {
                FloorPlanCanvasView(
                    viewModel: viewModel,
                    placementState: $placementState,
                    canvasTransform: $canvasTransform
                )

                FloorPlanControlsOverlayView(
                    viewModel: viewModel,
                    placementState: $placementState,
                    canvasTransform: $canvasTransform
                )
            }
            .navigationTitle("Floor Plan")
        }
    }
}
