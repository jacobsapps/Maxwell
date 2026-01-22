//
//  FloorPlanRoomLayerView.swift
//  Maxwell
//
//  Created by Jacob Bartlett on 21/01/2026.
//

import SwiftUI

struct FloorPlanRoomLayerView: View {
    let rooms: [FloorPlanRoom]
    let bulbs: [FloorPlanBulb]
    let center: CGPoint
    let transformScale: CGFloat
    let transformRotation: Angle
    let transformOffset: CGSize
    let isPlacementActive: Bool
    @Binding var isContentDragActive: Bool
    @Bindable var viewModel: FloorPlanBuilderViewModel

    var body: some View {
        ZStack {
            ForEach(rooms) { room in
                FloorPlanRoomView(
                    room: room,
                    center: center,
                    transformScale: transformScale,
                    transformRotation: transformRotation,
                    isContentDragActive: $isContentDragActive,
                    viewModel: viewModel
                )
            }

            ForEach(bulbs) { bulb in
                FloorPlanBulbView(
                    bulb: bulb,
                    center: center,
                    transformScale: transformScale,
                    transformRotation: transformRotation,
                    isContentDragActive: $isContentDragActive,
                    viewModel: viewModel
                )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .scaleEffect(transformScale)
        .rotationEffect(transformRotation)
        .offset(transformOffset)
        .allowsHitTesting(!isPlacementActive)
    }
}
