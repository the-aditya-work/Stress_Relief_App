//
//  File.swift
//  Stress_Relief_App
//
//  Created by Batch -2  on 13/02/25.
//

import SwiftUI

struct MemoryDetailScreen : View {
    let memory: Memory
    
    var body: some View {
            VStack(spacing: 10) {
                if let imageData = memory.imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 250)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding()
                        
                }

                Text(memory.title)
                    .font(.title3)
                    .fontWeight(.medium)

                Text(memory.date, style: .date)
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Text(memory.description)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Spacer()
                
            }
            .navigationTitle("Memory Details")
            .padding()
        }
}
