//
//  MemoryJarScreen.swift
//  Stress_Relief_App
//
//  Created by Aditya Rai on 12/02/25.
//
import SwiftUI
import PhotosUI

struct MemoryJarScreen: View {
    @State private var memories: [Memory] = []
    @State private var isAddingMemory = false
    
    var body: some View {
        NavigationView {
            
            VStack(spacing: 20){
                Text("Mood Booster Jar")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top , 10)
                
                if memories.isEmpty {
                    Image("memory")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(10)
                        .frame(width: 350, height: 200)
                        .padding(.top, 20)
                    
                    Text("Your memory jar is empty. Start by adding a memory!")
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .padding(.top, 10)
                    Text(" 🌟 Capture your happy moments, big or small, and revisit them whenever you need a smile. Reliving positive memories can boost your mood, reduce stress, and remind you of life’s joyful moments!")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                } else {
                    List(memories) { memory in
                        NavigationLink(destination: MemoryDetailScreen(memory: memory)){
                            MemoryRow(memory: memory)
                        }
                    }
                }
                
                Button(action: { isAddingMemory.toggle() }) {
                    Text("Add New Memory")
                        .customButtonStyle()
                }
            }
            .sheet(isPresented: $isAddingMemory){
                AddMemoryScreen(memories: $memories)
            }
            .padding()
        }
    }
        
}

extension View {
    func customButtonStyle() -> some View {
        self.padding()
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.horizontal)
    }
}
