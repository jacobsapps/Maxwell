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

    @ScaledMetric(relativeTo: .body) private var horizontalPadding: CGFloat = 20
    @ScaledMetric(relativeTo: .body) private var glassSpacing: CGFloat = 24

    var body: some View {
        let controlsHidden = placementState != nil

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
            FloorPlanPaletteView(controlsHidden: controlsHidden) { item in
                placementState = FloorPlanPlacementState(item: item)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
