//
//  FloorPlanRoomNameView.swift
//  Maxwell
//
//  Created by Codex on 23/01/2026.
//

import SwiftUI

struct FloorPlanRoomNameView: View {
    let room: FloorPlanRoom
    @Binding var isContentDragActive: Bool
    @Bindable var viewModel: FloorPlanBuilderViewModel

    @FocusState private var isFocused: Bool
    @State private var draftName = ""
    @State private var isEditing = false

    var body: some View {
        let maxWidth = max(0, room.size.width - BulbSpacing.lg)

        Group {
            if isEditing {
                TextField("Room name", text: $draftName)
                    .multilineTextAlignment(.center)
                    .textInputAutocapitalization(.words)
                    .submitLabel(.done)
                    .focused($isFocused)
                    .onSubmit {
                        commitName()
                    }
            } else {
                Button {
                    beginEditing()
                } label: {
                    Text(room.name)
                        .lineLimit(1)
                        .minimumScaleFactor(0.6)
                }
                .buttonStyle(.plain)
            }
        }
        .font(.caption)
        .foregroundStyle(.primary)
        .frame(maxWidth: maxWidth)
        .padding(.horizontal, BulbSpacing.sm)
        .padding(.vertical, BulbSpacing.xs)
        .background(.thinMaterial, in: .capsule)
        .padding(.bottom, BulbSpacing.xs)
        .accessibilityLabel(Text("Room name"))
        .accessibilityIdentifier("FloorPlanRoomName")
        .onAppear {
            draftName = room.name
        }
        .onChange(of: room.name) { _, newValue in
            guard isEditing == false else { return }
            draftName = newValue
        }
        .onChange(of: isFocused) { _, newValue in
            if newValue == false, isEditing {
                commitName()
            }
        }
    }

    private func beginEditing() {
        draftName = room.name
        isEditing = true
        isContentDragActive = true
        isFocused = true
    }

    private func commitName() {
        let trimmed = draftName.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.isEmpty {
            draftName = room.name
        } else if trimmed != room.name {
            viewModel.renameRoom(id: room.id, name: trimmed)
            draftName = trimmed
        }
        isEditing = false
        isContentDragActive = false
        isFocused = false
    }
}
