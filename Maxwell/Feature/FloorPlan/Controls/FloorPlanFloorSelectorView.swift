//
//  FloorPlanFloorSelectorView.swift
//  Maxwell
//
//  Created by Jacob Bartlett on 21/01/2026.
//

import SwiftUI

struct FloorPlanFloorSelectorView: View {
    @Bindable var viewModel: FloorPlanBuilderViewModel
    let controlsHidden: Bool

    @ScaledMetric(relativeTo: .body) private var segmentSize: CGFloat = 30

    @State private var isRenaming = false
    @State private var renameText = ""
    @State private var renameFloorID: UUID?

    var body: some View {
        VStack(spacing: 0) {
            FloorPlanIconButton(symbol: "plus", label: "Add Floor Above", position: .top, size: segmentSize) {
                viewModel.addFloorAbove()
            }

            ForEach(viewModel.floors.enumerated(), id: \.element.id) { _, floor in
                FloorPlanFloorButton(
                    title: floor.name,
                    isSelected: floor.id == viewModel.selectedFloorID,
                    position: .middle,
                    size: segmentSize
                ) {
                    viewModel.selectFloor(id: floor.id)
                }
                .simultaneousGesture(
                    LongPressGesture(minimumDuration: 0.4)
                        .onEnded { _ in
                            renameFloorID = floor.id
                            renameText = floor.name
                            isRenaming = true
                        }
                )
            }

            FloorPlanIconButton(symbol: "plus", label: "Add Floor Below", position: .bottom, size: segmentSize) {
                viewModel.addFloorBelow()
            }
        }
        .frame(width: segmentSize, height: totalHeight, alignment: .top)
        .offset(x: controlsHidden ? -segmentSize - horizontalOffset : 0)
        .opacity(controlsHidden ? 0 : 1)
        .allowsHitTesting(!controlsHidden)
        .alert("Rename Floor", isPresented: $isRenaming) {
            TextField("Name", text: $renameText)
            Button("Save") {
                if let id = renameFloorID {
                    viewModel.renameFloor(id: id, name: renameText)
                }
                renameFloorID = nil
            }
            Button("Cancel", role: .cancel) {
                renameFloorID = nil
            }
        }
    }

    private var totalHeight: CGFloat {
        segmentSize * CGFloat(viewModel.floors.count + 2)
    }

    private var horizontalOffset: CGFloat {
        segmentSize * 1.2
    }
}
