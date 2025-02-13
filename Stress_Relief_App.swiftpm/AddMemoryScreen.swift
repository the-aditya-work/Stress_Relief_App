//
//  File.swift
//  Stress_Relief_App
//
//  Created by Batch -2  on 13/02/25.
//

import SwiftUI
import PhotosUI

struct AddMemoryScreen: View {
    @Environment(\.dismiss) var dismiss
    @Binding var memories: [Memory]

    @State private var title = ""
    @State private var description = ""
    @State private var date = Date()
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var imageData: Data? = nil

    var body: some View {
        NavigationView {
            VStack(spacing: 15) {
                TextField("Memory Title", text: $title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                TextField("Description", text: $description)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    .padding(.horizontal)

                DatePicker("Select Date", selection: $date, displayedComponents: .date)
                    .datePickerStyle(CompactDatePickerStyle())
                    .padding(.horizontal)

                PhotosPicker(selection: $selectedItem, matching: .images) {
                    Text("Select an Image")
                        .foregroundColor(.blue)
                }
                .onChange(of: selectedItem) { newItem in
                    Task {
                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                            imageData = data
                        }
                    }
                }

                if let imageData = imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding()
                }

                Button(action: saveMemory) {
                    Text("Save Memory")
                        .customButtonStyle()
                        .padding(.bottom , 50)
                }
            }
            .navigationTitle("Add Memory")
            .navigationBarTitleDisplayMode(.inline)
            .padding()
            .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button("Cancel") {
                                    dismiss()
                                }
                            }
                        }
            }
        }
    

    func saveMemory() {
        guard !title.isEmpty, !description.isEmpty else { return }
        let newMemory = Memory(title: title, description: description, date: date, imageData: imageData)
        memories.append(newMemory)
        dismiss()
    }
}

