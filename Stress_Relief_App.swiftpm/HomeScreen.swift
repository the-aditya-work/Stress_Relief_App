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
            
            VStack(spacing: 20){
                
                Text("Stress Relief Companion")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.top,-20)
                
                Text("Reduce stress with guided breathing, relaxing sounds, and yoga.")
                    .font(.subheadline)
                //.foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.top, 10)
                
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding(.top, 20)
                
                NavigationLink(destination: BreathingExerciseScreen()) {
                    Text("Start Breathing Exercise")
                        .buttonStylePrimary()
                    //.padding(.top, 50)
                }
                
                Text("Play Relaxing Sounds")
                    .buttonStylePrimary()
                
                Text("Explore Yoga Poses")
                    .buttonStylePrimary()
            }
        }
    }
}

extension View {
    func buttonStylePrimary() -> some View {
        self.font(.headline)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.horizontal)
        
    }
}
