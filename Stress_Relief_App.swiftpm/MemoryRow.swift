//
//  File.swift
//  Stress_Relief_App
//
//  Created by Aditya Rai  on 13/02/25.
//
import SwiftUI

struct MemoryRow: View {
    let memory: Memory
    let onLongPress: (() -> Void)?
    
    var body: some View {
        HStack(spacing: 12) {
            if let imageData = memory.imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 2)
            } else {
                Image(systemName: "photo.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.gray.opacity(0.5))
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(memory.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(memory.date, style: .date)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
        .onLongPressGesture {
            onLongPress?()
        }
    }
}

