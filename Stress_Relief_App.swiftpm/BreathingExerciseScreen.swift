//
//  BreathingExerciseScreen.swift
//  Stress_Relief_App
//
//  Created by Aditya Rai on 12/02/25.
//
  
import SwiftUI

struct BreathingExerciseScreen: View {
    @State private var isAnimating = false
    @State private var circleSize: CGFloat = 150
    @State private var breathText = "Inhale"
    @State private var circleColor = Color.green.opacity(0.6)
    @State private var timer: Timer?
    
    var body: some View {
        
        VStack {
        VStack(spacing: 8){
            Text("Breathing Exercise")
                .font(.system(size: 28, weight: .bold, design: .default))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .padding(.top, 10)
            
            Text("Follow the circle: expand as you inhale, contract as you exhale.")
                .font(.system(size: 15, weight: .regular, design: .default))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
        }
        .padding(.top, 10)
        
        Spacer(minLength: 10)
        
            ZStack{
                Circle()
                    .frame(width: circleSize, height: circleSize)
                    .foregroundColor(circleColor)
                    .animation(.easeInOut(duration: 4), value:  circleSize)
                
                Text(breathText)
                    .font(.title)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                }
            .shadow(radius: 10)
            
            Spacer()
            
            Button(action: toggleBreathing) {
                Text(isAnimating ? "Stop" : "Start")
                    .font(.headline)
                    .frame(maxWidth: 200 , minHeight: 55)
                    .background(isAnimating ? Color.red : Color.blue)
                    .foregroundStyle(.white)
                    .clipShape(Capsule())
                    .shadow(radius: 5)
                    .padding(.bottom, 30)
            }
        }
        .padding()
    }
    
    private func toggleBreathing() {
        if isAnimating {
            stopBreathing()
        } else {
            startBreathing()
        }
    }
    
    private func startBreathing() {
        isAnimating = true
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { _ in
            DispatchQueue.main.async {
                if circleSize == 150 {
                    circleSize = 300
                    breathText = "Inhale"
                    circleColor = Color.green.opacity(0.6)
                }else {
                    circleSize = 150
                    breathText = "Exhale"
                    circleColor = Color.purple.opacity(0.6)
                }
            }
            
        }
        timer?.fire()
    }
    private func stopBreathing() {
        isAnimating = false
        timer?.invalidate()
        breathText = "Inhale"
        circleSize = 150
        circleColor = Color.purple.opacity(0.6)
    }
}

