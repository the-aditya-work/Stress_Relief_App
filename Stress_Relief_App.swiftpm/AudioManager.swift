//
//  AudioManager.swift
//  Stress_Relief_App
//
//  Created by Aditya Rai on 16/02/25.
//

import AVFoundation

class AudioManager: ObservableObject {
    private var audioPlayer: AVAudioPlayer?
    @Published var isPlaying = false

    func loadSound(file: String) {
        if let url = Bundle.main.url(forResource: file, withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.prepareToPlay()
                print("Successfully loaded \(file).mp3")
            } catch {
                print("Error loading sound: \(error.localizedDescription)")
            }
        } else {
            print("File not found: \(file).mp3")
        }
    }

    func togglePlayPause() {
        guard let player = audioPlayer else { return }
        
        if player.isPlaying {
            player.pause()
            isPlaying = false
        } else {
            player.play()
            isPlaying = true
        }
    }

    func play() {
        audioPlayer?.play()
        isPlaying = true
    }

    func stopSound() {
        audioPlayer?.stop()
        isPlaying = false
    }
}
