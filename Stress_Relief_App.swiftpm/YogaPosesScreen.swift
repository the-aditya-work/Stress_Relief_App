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
        ("Warrior II (Virabhadrasana II)", "Builds strength, enhances focus, and relieves mental stress.", "warrior_ii"),
        ("Legs Up the Wall (Viparita Karani)", "Improves circulation, calms the mind, and reduces fatigue.", "Legs_Up_the_Wall"),
        ("Standing Forward Bend (Uttanasana)", "Increases blood flow to the brain, stretches the hamstrings, and relieves stress.", "Standing_Forward_Bend"),
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Yoga is the journey of the self, through the self, to the self.")
                    .font(.caption)
                    .fontWeight(.medium)
                    .padding(.horizontal)
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                
                ForEach(poses, id: \.0) { pose in
                    NavigationLink(destination: YogaPoseDetailView(pose: pose, steps: getPoseSteps(for: pose.0))) {
                        VStack(alignment: .leading) {
                            Text(pose.0)
                                .font(.headline)
                                .foregroundColor(.blue)
                            
                            Text(pose.1)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.horizontal)
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
        VStack {
            Image(pose.2)
                .resizable()
                .scaledToFit()
                .frame(height: 300)
                .padding()
            
            Text(pose.0)
                .font(.headline)
                .fontWeight(.bold)
                .padding(.bottom,-10)
            
            // Display the steps
            VStack(alignment: .leading, spacing: 10) {
                ForEach(steps, id: \.self) { step in
                    Text("• \(step)")
                        .font(.body)
                        .padding(.horizontal)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                }
            }
            .padding(.top, 20)
            
            Spacer()
        }
        .navigationTitle(pose.0)
        .navigationBarTitleDisplayMode(.inline)
    }
}


