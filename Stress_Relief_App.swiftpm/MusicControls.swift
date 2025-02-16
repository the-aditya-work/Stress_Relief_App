//
//  MusicControls.swift
//  Stress_Relief_App
//
//  Created by Aditya Rai on 16/02/25.
//

import SwiftUI

struct MusicControls: View {
    @Binding var isPlaying: Bool
    var onPlayPause: () -> Void
    var onNext: () -> Void
    var onPrevious: () -> Void

    var body: some View {
        HStack(spacing: 40) {
            Button(action: onPrevious) {
                Image(systemName: "backward.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.white)
            }

            Button(action: onPlayPause) {
                Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .foregroundColor(.white)
            }

            Button(action: onNext) {
                Image(systemName: "forward.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.white)
            }
        }
        .padding()
    }
}

