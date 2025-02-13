//
//  File.swift
//  Stress_Relief_App
//
//  Created by Batch -2  on 13/02/25.
//

import SwiftUI

struct MemoryRow: View {
    let memory: Memory
    var body: some View {
        HStack {
                    if let imageData = memory.imageData, let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    VStack(alignment: .leading) {
                        Text(memory.title)
                            .font(.headline)
                            .foregroundColor(.blue)
                        Text(memory.date, style: .date)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
          }
    }
}
