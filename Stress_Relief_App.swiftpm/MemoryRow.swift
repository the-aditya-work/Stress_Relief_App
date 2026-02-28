//
//  MemoryRow.swift
//  Stress_Relief_App
//
//  Created by Aditya Rai on 13/02/25.
//
import SwiftUI

struct MemoryRow: View {
    let memory: Memory
    let onLongPress: (() -> Void)?

    var body: some View {
        HStack(spacing: 12) {
            // Thumbnail
            if let imageData = memory.imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 56, height: 56)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            } else {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color(.systemGray5))
                    .frame(width: 56, height: 56)
                    .overlay(
                        Image(systemName: "photo")
                            .font(.system(size: 22))
                            .foregroundColor(Color(.systemGray2))
                    )
            }

            // Text stack
            VStack(alignment: .leading, spacing: 3) {
                Text(memory.title)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)

                Text(memory.date, style: .date)
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
        .onLongPressGesture {
            onLongPress?()
        }
    }
}
