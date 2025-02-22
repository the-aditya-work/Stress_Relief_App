//
//  File.swift
//  Stress_Relief_App
//
//  Created by Aditya Rai  on 13/02/25.
//

import SwiftUI
import PhotosUI
import UIKit
import AVFoundation

struct AddMemoryScreen: View {
    @Environment(\.dismiss) var dismiss
    @Binding var memories: [Memory]
    
    @State private var title = ""
    @State private var description = ""
    @State private var date = Date()
    
    @State private var selectedImage: UIImage? = nil
    @State private var selectedAudioData: Data? = nil
    @State private var selectedVideoURL: URL? = nil
    
    @State private var showImagePicker = false
    @State private var showAudioPicker = false
    @State private var showVideoPicker = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Memory Details")) {
                    TextField("Memory Title", text: $title)
                        .padding(.horizontal)
                    
                    TextField("Body", text: $description, axis: .vertical)
                        .lineLimit(5, reservesSpace: true)
                        .padding(.horizontal)
                }
                
                Section(header: Text("Date & Time")) {
                    DatePicker("Select Date", selection: $date, displayedComponents: .date)
                        .datePickerStyle(CompactDatePickerStyle())
                        .padding(.horizontal)
                    
                }
                
                Section(header: Text("Attachments")) {
                    Button("Select Image") {
                        showImagePicker = true
                    }
                    Button("Select Audio") {
                        showAudioPicker = true
                    }
                    Button("Select Video") {
                        showVideoPicker = true
                    }
                    
                    
                    if let selectedImage = selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .padding(.top, 10)
                    }
                    
                    
                    if let selectedAudioData = selectedAudioData {
                        Text("Audio Selected")
                            .padding(.top, 10)
                    }
                    
                    
                    if let selectedVideoURL = selectedVideoURL {
                        Text("Video Selected: \(selectedVideoURL.lastPathComponent)")
                            .padding(.top, 10)
                    }
                }
            }
            .navigationTitle("Add Memory")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button("Cancel") {
                dismiss()
            }, trailing: Button("Save") {
                saveMemory()
                dismiss()
            })
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(selectedImage: $selectedImage)
            }
            .sheet(isPresented: $showAudioPicker) {
                AudioPicker(selectedAudioData: $selectedAudioData)
            }
            .sheet(isPresented: $showVideoPicker) {
                VideoPicker(selectedVideoURL: $selectedVideoURL)
            }
        }
    }
    
    
    func saveMemory() {
        guard !title.isEmpty, !description.isEmpty else { return }
        let newMemory = Memory(
            title: title,
            description: description,
            date: date,
            imageData: selectedImage?.jpegData(compressionQuality: 1.0),
            audioData: selectedAudioData,
            videoURL: selectedVideoURL
        )
        memories.append(newMemory)
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            picker.dismiss(animated: true)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary 
        picker.delegate = context.coordinator
        picker.mediaTypes = ["public.image", "public.movie"]
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

struct AudioPicker: UIViewControllerRepresentable {
    @Binding var selectedAudioData: Data?
    
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var parent: AudioPicker
        
        init(parent: AudioPicker) {
            self.parent = parent
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            if let url = urls.first {
                do {
                    let data = try Data(contentsOf: url)
                    parent.selectedAudioData = data
                } catch {
                    print("Error reading audio file: \(error)")
                }
            }
        }
        
        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {}
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: [.audio])
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}
}

struct VideoPicker: UIViewControllerRepresentable {
    @Binding var selectedVideoURL: URL?
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: VideoPicker
        
        init(parent: VideoPicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let url = info[.mediaURL] as? URL {
                parent.selectedVideoURL = url
            }
            picker.dismiss(animated: true)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = context.coordinator
        picker.mediaTypes = ["public.movie"]
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

