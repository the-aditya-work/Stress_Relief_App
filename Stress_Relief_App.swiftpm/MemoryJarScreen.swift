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
    @State private var showingWelcomePopup = false
    @State private var showingActionSheet = false
    @State private var selectedMemoryIndex: Int?
    @State private var showingEditSheet = false
    @State private var editingMemory: Memory?
    
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
                        
                        Text(" 🌟 Capture your happy moments, big or small, and revisit them whenever you need a smile. Reliving positive memories can boost your mood, reduce stress, and remind you of life's joyful moments!")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal,32)
                    }
                }
                else {
                    List(memories) { memory in
                        NavigationLink(destination: MemoryDetailScreen(memory: memory)){
                            MemoryRow(memory: memory, onLongPress: {
                                selectedMemoryIndex = memories.firstIndex { $0.id == memory.id }
                                editingMemory = memory
                                showingActionSheet = true
                            })
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
            .background(Color.white)
            .sheet(isPresented: $isAddingMemory){
                AddMemoryScreen(memories: $memories)
            }
            .onAppear {
                // Show welcome popup on first visit
                if !UserDefaults.standard.bool(forKey: "hasSeenMemoryWelcome") {
                    showingWelcomePopup = true
                }
            }
            .fullScreenCover(isPresented: $showingWelcomePopup) {
                MemoryWelcomePopup()
            }
            .sheet(isPresented: $showingEditSheet) {
                if let memory = editingMemory {
                    EditMemorySheet(
                        memory: memory,
                        memories: $memories
                    )
                }
            }
            .actionSheet(isPresented: $showingActionSheet) {
                ActionSheet(
                    title: Text("Memory Options"),
                    message: Text("What would you like to do with this memory?"),
                    buttons: [
                        .default(Text("Edit")) {
                            showingEditSheet = true
                        },
                        .destructive(Text("Delete")) {
                            deleteMemory()
                        },
                        .cancel()
                    ]
                )
            }
            //.navigationTitle("Mood Booster Jar")
            .navigationBarTitleDisplayMode(.inline)
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func deleteMemory() {
        if let index = selectedMemoryIndex {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                memories.remove(at: index)
            }
            selectedMemoryIndex = nil
            editingMemory = nil
        }
    }
}

struct MemoryWelcomePopup: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 32) {
                    // Header
                    VStack(spacing: 16) {
                        Image("memory")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .cornerRadius(20)
                        
                        Text("Welcome to Mood Booster Jar!")
                            .font(.system(size: 25, weight: .semibold, design: .rounded))
                            .multilineTextAlignment(.center)
                        
                        Text("Your personal collection of happy memories and joyful moments")
                            .font(.system(size: 18, weight: .regular))
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 32)
                    }
                    .padding(.top, 20)
                    
                    // Features
                    VStack(spacing: 24) {
                        MemoryFeatureRow(
                            icon: "plus.circle.fill",
                            iconColor: .blue,
                            title: "Add Happy Memories",
                            description: "Capture your special moments with photos and descriptions. Add memories whenever something makes you smile!"
                        )
                        
                        MemoryFeatureRow(
                            icon: "photo.fill",
                            iconColor: .green,
                            title: "Photo Memories",
                            description: "Attach photos to your memories to make them even more special. Visual reminders can instantly boost your mood."
                        )
                        
                        MemoryFeatureRow(
                            icon: "heart.fill",
                            iconColor: .pink,
                            title: "Mood Boosting",
                            description: "Revisit your happy memories whenever you're feeling down. Reliving positive experiences can reduce stress and improve your mood."
                        )
                        
                        MemoryFeatureRow(
                            icon: "clock.arrow.circlepath",
                            iconColor: .orange,
                            title: "Memory Timeline",
                            description: "All your memories are organized by date, making it easy to find and relive your favorite moments from any time."
                        )
                    }
                    .padding(.horizontal, 24)
                    
                    // Warning Section
                    VStack(spacing: 16) {
                        HStack(spacing: 12) {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(.orange)
                            
                            Text("Important Note")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.primary)
                        }
                        
                        Text("⚠️ Warning: If you clear your app cache or uninstall and reinstall the app, all your saved memories will be lost. Make sure to backup important memories elsewhere if needed.")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .background(Color(.systemOrange).opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .padding(.horizontal, 24)
                    
                    // Continue Button
                    Button(action: {
                        UserDefaults.standard.set(true, forKey: "hasSeenMemoryWelcome")
                        dismiss()
                    }) {
                        Text("Get Started")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 18)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.85)]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(color: .blue.opacity(0.25), radius: 10, x: 0, y: 4)
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 20)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing: Button("Skip") {
                    UserDefaults.standard.set(true, forKey: "hasSeenMemoryWelcome")
                    dismiss()
                }
                .foregroundColor(.blue)
            )
        }
    }
}

struct MemoryFeatureRow: View {
    let icon: String
    let iconColor: Color
    let title: String
    let description: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 24, weight: .medium))
                .foregroundColor(iconColor)
                .frame(width: 32)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.primary)
                
                Text(description)
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.secondary)
                    .lineLimit(nil)
                    .multilineTextAlignment(.leading)
            }
            
            Spacer()
        }
        .padding(20)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
}

#Preview {
    MemoryJarScreen()
}

struct EditMemorySheet: View {
    let memory: Memory
    @Binding var memories: [Memory]
    @Environment(\.dismiss) private var dismiss
    @State private var editedTitle: String
    @State private var editedDescription: String
    @FocusState private var isTitleFocused: Bool
    
    init(memory: Memory, memories: Binding<[Memory]>) {
        self.memory = memory
        self._memories = memories
        self._editedTitle = State(initialValue: memory.title)
        self._editedDescription = State(initialValue: memory.description)
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                // Header
                VStack(spacing: 16) {
                    Image("memory")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .cornerRadius(16)
                    
                    Text("Edit Memory")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .multilineTextAlignment(.center)
                    
                    Text("Modify your happy memory")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 20)
                
                // Edit Fields
                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Title")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.primary)
                        
                        TextField("Memory title", text: $editedTitle)
                            .font(.system(size: 17, weight: .regular))
                            .padding(16)
                            .background(Color(.systemGray6))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .focused($isTitleFocused)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Description")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.primary)
                        
                        TextField("Memory description", text: $editedDescription, axis: .vertical)
                            .font(.system(size: 17, weight: .regular))
                            .padding(16)
                            .background(Color(.systemGray6))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .lineLimit(3...6)
                    }
                }
                .padding(.horizontal, 24)
                
                Spacer()
                
                // Save Button
                Button(action: saveEditedMemory) {
                    HStack(spacing: 8) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 18, weight: .medium))
                        Text("Save Changes")
                            .font(.system(size: 18, weight: .semibold))
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 18)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.85)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .shadow(color: .blue.opacity(0.25), radius: 10, x: 0, y: 4)
                }
                .disabled(editedTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                .opacity(editedTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 0.6 : 1.0)
                .padding(.horizontal, 24)
                .padding(.bottom, 20)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    dismiss()
                }
                .foregroundColor(.blue),
                trailing: Button("Done") {
                    saveEditedMemory()
                }
                .foregroundColor(.blue)
                .disabled(editedTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            )
        }
        .onAppear {
            isTitleFocused = true
        }
    }
    
    private func saveEditedMemory() {
        let trimmedTitle = editedTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedDescription = editedDescription.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if !trimmedTitle.isEmpty {
            if let index = memories.firstIndex(where: { $0.id == memory.id }) {
                let updatedMemory = Memory(
                    title: trimmedTitle,
                    description: trimmedDescription,
                    date: memory.date,
                    imageData: memory.imageData,
                    audioData: memory.audioData,
                    videoURL: memory.videoURL
                )
                
                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                    memories[index] = updatedMemory
                }
            }
            dismiss()
        }
    }
}
