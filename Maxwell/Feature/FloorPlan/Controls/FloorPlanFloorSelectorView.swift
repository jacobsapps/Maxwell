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

    @ScaledMetric(relativeTo: .body) private var panelWidth: CGFloat = 96
    @ScaledMetric(relativeTo: .body) private var verticalPadding: CGFloat = 12
    @ScaledMetric(relativeTo: .body) private var itemSpacing: CGFloat = 10

    @State private var isRenaming = false
    @State private var renameText = ""
    @State private var renameFloorID: UUID?

    var body: some View {
        FloorPlanGlassPanel(cornerRadius: 20) {
            VStack(spacing: itemSpacing) {
                FloorPlanIconButton(symbol: "plus", label: "Add Above") {
                    viewModel.addFloorAbove()
                }

                ScrollView {
                    VStack(spacing: itemSpacing) {
                        ForEach(viewModel.floors) { floor in
                            FloorPlanFloorButton(
                                title: floor.name,
                                isSelected: floor.id == viewModel.selectedFloorID
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
                    }
                }
                .scrollIndicators(.hidden)

                FloorPlanIconButton(symbol: "plus", label: "Add Below") {
                    viewModel.addFloorBelow()
                }
            }
            .padding(.vertical, verticalPadding)
            .frame(width: panelWidth)
        }
        .offset(x: controlsHidden ? -panelWidth - horizontalOffset : 0)
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

    private var horizontalOffset: CGFloat {
        panelWidth * 0.6
    }
}
