//
//  MemoryDetailScreen.swift
//  Stress_Relief_App
//
//  Created by Aditya Rai on 13/02/25.
//

import SwiftUI

struct MemoryDetailScreen: View {
    let memory: Memory

    var body: some View {
        List {
            // Hero image — full-width, above everything else
            if let imageData = memory.imageData, let uiImage = UIImage(data: imageData) {
                Section {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .frame(height: 240)
                        .clipped()
                        .listRowInsets(EdgeInsets())       // bleed edge-to-edge
                }
            }

            // Date row
            Section {
                Label {
                    Text(memory.date, style: .date)
                        .foregroundColor(.secondary)
                } icon: {
                    Image(systemName: "calendar")
                        .foregroundColor(.secondary)
                }
            }

            // Description — only shown when non-empty
            if !memory.description.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                Section(header: Text("Memory")) {
                    Text(memory.description)
                        .font(.body)
                        .foregroundColor(.primary)
                }
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle(memory.title)
        .navigationBarTitleDisplayMode(.large)
    }
}
