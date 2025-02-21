//
//  PlayMusic.swift
//  Stress_Relief_App
//
//  Created by Batch -2  on 14/02/25.

import SwiftUI
import AVFoundation

struct MusicPlayerScreen: View {
    @State private var currentIndex = 0
    @State private var isPlaying = false
    @State private var showMusicList = false
    @StateObject private var audioManager = AudioManager()
    
    let sounds = SoundData.sounds
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.black, Color.purple.opacity(0.7)]),
                startPoint: .top, endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack {
               
                HStack {
                    Button(action: { showMusicList.toggle() }) {
                        Image(systemName: "list.bullet")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.white)
                            .padding(12)
                            .background(BlurView(style: .systemUltraThinMaterialDark))
                            .clipShape(Circle())
                    }
                    .padding(.leading)
                    
                    Spacer()
                }
                .padding(.top, 20)
                
                Spacer()
                
                
                Image(sounds[currentIndex].file)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 280, height: 280)
                    .cornerRadius(15)
                    .shadow(radius: 10)
                    .padding(.bottom, 20)
                
                Text(sounds[currentIndex].name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.bottom, 20)
                
                Spacer()
                
                
                HStack(spacing: 50) {
                    Image(systemName: "backward.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 24))
                        .onTapGesture { previousTrack() }
                    
                    Button(action: { togglePlayPause() }) {
                        Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                            .padding()
                            .background(BlurView(style: .systemUltraThinMaterialDark))
                            .clipShape(Circle())
                    }
                    
                    Image(systemName: "forward.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 24))
                        .onTapGesture { nextTrack() }
                }
                .padding()
                .background(BlurView(style: .systemChromeMaterialDark))
                .cornerRadius(20)
                .padding(.bottom, 80)
            }
        }
        .sheet(isPresented: $showMusicList) {
            MusicListView(sounds: sounds, selectTrack: selectTrack)
        }
        .onAppear { audioManager.loadSound(file: sounds[currentIndex].file) }
        .onDisappear { audioManager.stopSound() }
        
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


struct BlurView: UIViewRepresentable {
    let style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}


