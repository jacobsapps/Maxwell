//
//  FloorPlanBulbView.swift
//  Maxwell
//
//  Created by Jacob Bartlett on 21/01/2026.
//

import SwiftUI

struct FloorPlanBulbView: View {
    let bulb: FloorPlanBulb
    let center: CGPoint
    let transformScale: CGFloat
    let transformRotation: Angle
    @Binding var isContentDragActive: Bool
    @Bindable var viewModel: FloorPlanBuilderViewModel

    @GestureState private var dragTranslation: CGSize = .zero
    @ScaledMetric(relativeTo: .body) private var bulbSize: CGFloat = 18

    var body: some View {
        let adjustedTranslation = adjustedTranslation(for: dragTranslation)
        let proposedPosition = CGPoint(
            x: bulb.position.x + adjustedTranslation.width,
            y: bulb.position.y + adjustedTranslation.height
        )
        let colorOption = BulbColorOption.option(for: bulb.colorId) ?? BulbColorOption.defaultOption
        let fittingAsset = BulbFittingFamily.imageAsset(for: bulb.fittingSize)
        let bulbOpacity = bulb.isWorking ? 1.0 : 0.35

        let bulbView = Circle()
            .fill(colorOption.color.opacity(bulbOpacity))
            .frame(width: bulbSize, height: bulbSize)
            .overlay {
                Circle()
                    .strokeBorder(.secondary.opacity(bulbOpacity), lineWidth: 2)
            }
            .position(x: center.x + proposedPosition.x, y: center.y + proposedPosition.y)

        Menu {
            Menu {
                ForEach(BulbFittingFamily.catalog) { family in
                    ForEach(family.sizes, id: \.self) { size in
                        Button {
                            viewModel.updateBulbFitting(id: bulb.id, fittingSize: size)
                        } label: {
                            Label {
                                Text(size)
                            } icon: {
                                Image(family.imageAsset)
                                    .renderingMode(.template)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 16, height: 16)
                            }
                        }
                    }
                }
            } label: {
                Label {
                    Text("Fitting: \(bulb.fittingSize)")
                } icon: {
                    Image(fittingAsset)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                }
            }

            Menu {
                ForEach(BulbColorOption.options) { option in
                    Button {
                        viewModel.updateBulbColor(id: bulb.id, colorId: option.id)
                    } label: {
                        Label {
                            Text(option.displayName)
                        } icon: {
                            Circle()
                                .fill(option.color)
                                .frame(width: 14, height: 14)
                        }
                    }
                }
            } label: {
                Label {
                    Text("Color: \(colorOption.displayName)")
                } icon: {
                    Circle()
                        .fill(colorOption.color)
                        .frame(width: 14, height: 14)
                }
            }

            Menu {
                Button {
                    viewModel.setBulbWorking(id: bulb.id, isWorking: true)
                } label: {
                    Label(
                        "Working",
                        systemImage: bulb.isWorking ? "checkmark.circle.fill" : "circle"
                    )
                }
                Button {
                    viewModel.setBulbWorking(id: bulb.id, isWorking: false)
                } label: {
                    Label(
                        "Broken",
                        systemImage: bulb.isWorking ? "circle" : "xmark.circle.fill"
                    )
                }
            } label: {
                Label(
                    bulb.isWorking ? "Status: Working" : "Status: Broken",
                    systemImage: bulb.isWorking ? "checkmark.circle" : "xmark.circle"
                )
            }
        } label: {
            bulbView
        }
        .simultaneousGesture(bulbDragGesture())
        .accessibilityLabel(Text("Bulb"))
        .accessibilityIdentifier("FloorPlanBulb")
    }

    private func bulbDragGesture() -> some Gesture {
        DragGesture()
            .onChanged { _ in
                isContentDragActive = true
            }
            .updating($dragTranslation) { value, state, _ in
                state = value.translation
            }
            .onEnded { value in
                isContentDragActive = false
                let adjustedTranslation = adjustedTranslation(for: value.translation)
                let proposedPosition = CGPoint(
                    x: bulb.position.x + adjustedTranslation.width,
                    y: bulb.position.y + adjustedTranslation.height
                )
                guard let room = viewModel.roomContaining(point: proposedPosition) else { return }
                viewModel.moveBulb(id: bulb.id, position: proposedPosition, roomID: room.id)
            }
    }

    private func adjustedTranslation(for translation: CGSize) -> CGSize {
        let scaled = CGPoint(
            x: translation.width / transformScale,
            y: translation.height / transformScale
        )
        let rotated = scaled.rotated(by: -transformRotation.radians)
        return CGSize(width: rotated.x, height: rotated.y)
    }
}
