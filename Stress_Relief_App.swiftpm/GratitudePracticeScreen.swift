//
//  GratitudePracticeScreen.swift
//  Stress_Relief_App
//
//  Created by Aditya Rai on 12/02/25.
//

import SwiftUI

struct GratitudePracticeScreen: View {
    @State private var gratitudeList: [(text: String, date: String)] = []
    @State private var newGratitude = ""
    
    var body: some View {
        NavigationView {
            VStack (spacing: 20){
                VStack(spacing: 8){
                    Text("Daily Gratitude Journal")
                        .font(.system(size: 28, weight: .bold, design: .default))
                        .multilineTextAlignment(.center)
                        .padding(.top, 20)
                    
                    Text("Start your day with gratitude! Write 3 things you're thankful for and brighten your mindset. ☀️")
                        .font(.system(size: 15, weight: .regular, design: .default))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal,30)
                }
                
                TextField("Enter gratitude here...", text: $newGratitude)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .shadow(radius: 3)
                    .padding(.horizontal)
                    .textFieldStyle(PlainTextFieldStyle())
                
                Button(action: addGratitude) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Add Gratitude")
                            .fontWeight(.bold)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    .shadow(radius: 3)
                }
                .padding(.horizontal)
                .padding(.bottom, 10)
                
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(gratitudeList, id: \ .text) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("• \(item.text)")
                                        .foregroundColor(.black)
                                        .fontWeight(.medium)
                                    Text(item.date)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                .shadow(radius: 2)
                            }
                            .padding(.horizontal)
                            .transition(.opacity)
                        }
                    }
                }
                Spacer()
            }
            .padding()
            .background(Color(.systemGray6).edgesIgnoringSafeArea(.all))
        }
    }
    
    func addGratitude() {
        if !newGratitude.isEmpty {
            let currentDate = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM d, yyyy - h:mm a"
            let dateString = formatter.string(from: currentDate)
            
            withAnimation {
                gratitudeList.append((text: newGratitude, date: dateString))
            }
            
            newGratitude = ""
        }
    }
}




