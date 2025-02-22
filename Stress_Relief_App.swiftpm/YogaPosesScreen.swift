//
//  YogaPosesScreen.swift
//  Stress_Relief_App
//
//  Created by Aditya Rai on 17/02/25.

import SwiftUI

struct YogaPosesScreen: View {
    let poses = [
        ("Mountain Pose (Tadasana)", "Improves posture and balance, promotes mindfulness and deep breathing, reduces anxiety, and enhances focus.", "mountain_pose"),
        ("Downward Dog (Adho Mukha Svanasana)", "Stretches the entire body to release tension, increases blood flow to the brain to reduce stress, and helps relieve headaches and fatigue.", "downward_dog"),
        ("Child’s Pose (Balasana)", "Calms the nervous system, relieves tension in the back, shoulders, and chest.", "child_pose"),
        ("Legs Up the Wall (Viparita Karani)", "Improves circulation, calms the mind, and reduces fatigue.", "Legs_Up_the_Wall"),
        ("Standing Forward Bend (Uttanasana)", "Increases blood flow to the brain, stretches the hamstrings, and relieves stress.", "Standing_Forward_Bend"),
    ]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
        ScrollView {
            VStack(spacing: 20) {
                Text("Yoga is the journey of the self, through the self, to the self.")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.black.opacity(0.3))
                    .cornerRadius(12)
                    .padding(.horizontal)
                
                ForEach(poses, id: \.0) { pose in
                    NavigationLink(destination: YogaPoseDetailView(pose: pose, steps: getPoseSteps(for: pose.0))) {
                        HStack {
                            Image(pose.2)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(radius: 5)
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text(pose.0)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                
                                Text(pose.1)
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.8))
                                    .lineLimit(2)
                            }
                            Spacer()
                        }
                        .padding()
                        .background(LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.8), Color.blue.opacity(0.8)]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(15)
                        .shadow(radius: 5)
                        .padding(.horizontal)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
        .navigationTitle("Yoga Poses")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct YogaPoseDetailView: View {
    let pose: (String, String, String)
    let steps: [String]
    
    var body: some View {
        ScrollView {
            VStack {
                Image(pose.2)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 10)
                    .padding()
                
                Text(pose.0)
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.bottom,10)
                
                
                VStack(alignment: .leading, spacing: 15) {
                    ForEach(steps, id: \.self) { step in
                        Text("• \(step)")
                            .font(.body)
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                    }
                }
                .padding()
                .background(Color.white.opacity(0.2))
                .cornerRadius(10)
                .padding()
                .shadow(radius: 5)
            }
        }
        .navigationTitle(pose.0)
        .navigationBarTitleDisplayMode(.inline)
    }
}


