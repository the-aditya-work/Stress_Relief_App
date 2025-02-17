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
        
        VStack(spacing: 20){
            
//            Text("Breathe In and Out")
//                .font(.title)
//                .fontWeight(.bold)
//                .padding(20)
            
            Spacer()
            
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
            
            Spacer()
            
            Text("Follow the circle: expand as you inhale, contract as you exhale.")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button(action: toggleBreathing) {
                Text(isAnimating ? "Stop" : "Start")
                    .padding()
                    .frame(width: 100 , height: 40)
                    .background(isAnimating ? Color.red : Color.green)
                    .foregroundStyle(.white)
                    .cornerRadius(10)
            }
            }
        .navigationTitle("Breathing Exercise")
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

