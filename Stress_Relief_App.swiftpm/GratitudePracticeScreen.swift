//
//  GratitudePracticeScreen.swift
//  Stress_Relief_App
//
//  Created by Aditya Rai on 12/02/25.
//
//import SwiftUI
//
//struct GratitudePracticeScreen: View {
//    @State private var gratitudeList: [String] = []
//    @State private var newGratitude = ""
//    @State private var showConfirmation = false
//    
//    var body: some View {
//        NavigationView {
//            VStack {
//                Text("Daily Gratitude Journal")
//                    .font(.title)
//                    .fontWeight(.medium)
//                    .padding()
//                //.foregroundStyle(.purple)
//                
//                Text("Start your day with gratitude! Write 3 things you're thankful for and brighten your mindset. ☀️")
//                    .font(.subheadline)
//                    .multilineTextAlignment(.center)
//                    .padding(.horizontal)
//                    .foregroundColor(.gray)
//                
//                TextField("Enter gratitude here...", text: $newGratitude)
//                 //.textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding()
//                    .background(Color(.systemGray6))
//                    .cornerRadius(10)
//                    .shadow(radius: 3)
//                    .padding(.horizontal)
//                
//                Button(action: addGratitude){
//                    HStack{
//                        Image(systemName: "plus.circle.fill")
//                        Text("Add Gratitude")
//                            .fontWeight(.bold)
//                    }
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .background(LinearGradient(gradient: Gradient(colors: [.purple, .pink]), startPoint: .leading, endPoint: .trailing))
//                    .foregroundStyle(.white)
//                    .cornerRadius(10)
//                    .shadow(radius: 3)
//                }
//                .padding(.horizontal)
//                .padding(.bottom, 10)
//
//                ScrollView {
//                    VStack(spacing: 10){
//                        ForEach(gratitudeList, id: \..self) { item in
//                            HStack {
//                                Text("• \(item)")
//                                    .padding()
//                                    .frame(maxWidth: .infinity, alignment: .leading)
//                                    .background(Color.white)
//                                    .cornerRadius(10)
//                                    .shadow(radius: 2)
//                            }
//                            .padding(.horizontal)
//                            .transition(.opacity)
//                            
//                        }
//                    }
//                }
//                
//                Spacer()
//                
//            }
//            .padding()
//            .background(Color(.systemGray6).edgesIgnoringSafeArea(.all))
//            .overlay(
//                showConfirmation ? ConfirmationView() : nil
//            )
//        }
//    }
//    
//    func addGratitude(){
//        if !newGratitude.isEmpty{
//            withAnimation {
//                gratitudeList.append(newGratitude)
//            }
//        
//        newGratitude = ""
//        showConfirmationAlert()
//        }
//    }
//    
//    func showConfirmationAlert() {
//        showConfirmation = true
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
//            showConfirmation = false
//        }
//    }
//    
//}
//
//struct ConfirmationView: View {
//    var body: some View {
//        
//        Text("🎉 Successfylly Added!")
//            
//            .font(.system(size: 25))
//            .offset(y: -180)
//            .transition(.scale)
//            
//              
//    }
//}

import SwiftUI

struct GratitudePracticeScreen: View {
    @State private var gratitudeList: [(text: String, date: String)] = []
    @State private var newGratitude = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Daily Gratitude Journal")
                    .font(.title)
                    .fontWeight(.medium)
                    .padding()
                
                Text("Start your day with gratitude! Write 3 things you're thankful for and brighten your mindset. ☀️")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .foregroundColor(.gray)
                
                TextField("Enter gratitude here...", text: $newGratitude)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .shadow(radius: 3)
                    .padding(.horizontal)
                
                Button(action: addGratitude) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Add Gratitude")
                            .fontWeight(.bold)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(LinearGradient(gradient: Gradient(colors: [.purple, .pink]), startPoint: .leading, endPoint: .trailing))
                    .foregroundStyle(.white)
                    .cornerRadius(10)
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
                                        .fontWeight(.medium)
                                    Text(item.date)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.white)
                                .cornerRadius(10)
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




