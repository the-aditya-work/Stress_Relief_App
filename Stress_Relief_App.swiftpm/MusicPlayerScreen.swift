//
//  PlayMusic.swift
//  Stress_Relief_App
//
//  Created by Batch -2  on 14/02/25.

import SwiftUI

struct MusicPlayerScreen: View {
    @State private var currentIndex = 0
    @State private var isPlaying = false
    @State private var showMusicList = false
    @StateObject private var audioManager = AudioManager()

    let sounds = SoundData.sounds

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Sidebar Button
                HStack {
                    Button(action: { showMusicList.toggle() }) {
                        Image(systemName: "line.horizontal.3")
                            .resizable()
                            .frame(width: 30, height: 20)
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
                .padding()

                Spacer()

                // Album Art
                Image(sounds[currentIndex].file)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .cornerRadius(20)
                    .shadow(radius: 10)

                // Song Title
                Text(sounds[currentIndex].name)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()

                // Music Controls
                MusicControls(
                    isPlaying: $isPlaying,
                    onPlayPause: togglePlayPause,
                    onNext: nextTrack,
                    onPrevious: previousTrack
                )

                Spacer()
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.black, Color.blue.opacity(0.6)]),
                    startPoint: .top, endPoint: .bottom
                )
                .ignoresSafeArea()
            )
            .navigationBarHidden(true)
            .sheet(isPresented: $showMusicList) {
                MusicListView(sounds: sounds, selectTrack: selectTrack)
            }
            .onAppear { audioManager.loadSound(file: sounds[currentIndex].file) }
            .onDisappear { audioManager.stopSound() }
        }
    }
    
    func togglePlayPause() {
        audioManager.togglePlayPause()
        isPlaying = audioManager.isPlaying
    }

    func nextTrack() {
        currentIndex = (currentIndex + 1) % sounds.count
        audioManager.loadSound(file: sounds[currentIndex].file)
        audioManager.play()
        isPlaying = true
    }

    func previousTrack() {
        currentIndex = (currentIndex - 1 + sounds.count) % sounds.count
        audioManager.loadSound(file: sounds[currentIndex].file)
        audioManager.play()
        isPlaying = true
    }

    func selectTrack(index: Int) {
        currentIndex = index
        audioManager.loadSound(file: sounds[currentIndex].file)
        audioManager.play()
        isPlaying = true
        showMusicList = false
    }
}
