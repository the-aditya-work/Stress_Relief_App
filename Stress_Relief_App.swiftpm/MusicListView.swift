//
//  MusicListView.swift
//  Stress_Relief_App
//
//  Created by Aditya Rai on 16/02/25.
//

import SwiftUI

struct MusicListView: View {
    let sounds: [(name: String, file: String)]
    let selectTrack: (Int) -> Void
    
    var body: some View {
        NavigationView {
            List {
                ForEach(sounds.indices , id: \.self) { index in
                    Button(action: {
                        selectTrack(index)
                    }) {
                        HStack {
                            Image(systemName: "music.note")
                                .foregroundColor(.blue)
                            Text(sounds[index].name)
                                .font(.headline)
                                .foregroundColor(.black)
                        }
                        .padding()
                    }
                    
                }
            }
            .navigationTitle(Text("Music Library"))
        }
    }
}

