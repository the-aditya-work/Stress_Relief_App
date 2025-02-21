//
//  HomeScreen.swift
//  Stress_Relief_App
//
//  Created by Aditya Rai on 12/02/25.
//
import SwiftUI
import AVFoundation

struct HomeScreen: View {
    var body: some View {
        NavigationView {
            
            VStack(spacing: 24){
                Spacer(minLength: 40)
                
                VStack(spacing: 8) {
                    Text("Stress Relief Companion")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Text("Reduce stress with guided breathing, relaxing sounds, and yoga.")
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                }
                
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 220, height: 220)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .shadow(radius: 5)
                    .padding(.top, 20)
                
                Spacer()
                
                VStack(spacing: 16) {
                    NavigationLink(destination: BreathingExerciseScreen()) {
                        Label("Start Breathing Exercise", systemImage: "lungs.fill")
                            .buttonStylePrimary()
                    }
                    
                    NavigationLink(destination: MusicPlayerScreen()) {
                        Label("Play Relaxing Sounds", systemImage: "music.note.list")
                            .buttonStylePrimary()
                    }
                    
                    NavigationLink(destination: YogaPosesScreen()) {
                        
                        Label("Explore Yoga Poses", systemImage: "figure.yoga")
                            .buttonStylePrimary()
                        
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 0)
                Spacer(minLength: 30)
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

extension View {
    func buttonStylePrimary() -> some View {
        self.font(.headline)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.accentColor)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .shadow(radius: 3)
            .padding(.horizontal)
        
    }
}
