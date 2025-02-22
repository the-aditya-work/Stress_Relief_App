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
            
            VStack(spacing: 16){
                Text("Mood Booster Jar")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .padding(.top , 16)
                
                if memories.isEmpty {
                    VStack(spacing: 12) {
                        Image("memory")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(16)
                            .frame(width: 350, height: 200)
                            .padding(.top, 32)
                        
                        Text("Your memory jar is empty. Start by adding a memory!")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                        
                        Text(" 🌟 Capture your happy moments, big or small, and revisit them whenever you need a smile. Reliving positive memories can boost your mood, reduce stress, and remind you of life’s joyful moments!")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal,32)
                    }
                }
                else {
                    List(memories) { memory in
                        NavigationLink(destination: MemoryDetailScreen(memory: memory)){
                            MemoryRow(memory: memory)
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                }
                
                Button(action: { isAddingMemory.toggle() }) {
                    Text("Add New Memory")
                        .font(.headline)
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 30)
                        .padding(.bottom, 16)
                }
            }
            .padding(.top, 20)
            .background(Color(.systemBackground))
            .sheet(isPresented: $isAddingMemory){
                AddMemoryScreen(memories: $memories)
            }
            //.navigationTitle("Mood Booster Jar")
            .navigationBarTitleDisplayMode(.inline)
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
}
