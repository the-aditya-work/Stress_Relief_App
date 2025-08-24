//
//  Onboarding.swift
//  Stress_Relief_App
//
//  Created by Aditya Rai on 12/02/25.
//

import SwiftUI

struct Onboarding: View {
    @State private var currentPage = 0
    @Binding var isPresented: Bool
    
    private let onboardingPages = [
        OnboardingPage(
            icon: "house.fill",
            iconColor: .blue,
            title: "Welcome to Stress Relief",
            subtitle: "Your personal wellness companion",
            description: "Discover a complete toolkit designed to help you manage stress, practice gratitude, and create lasting memories. Start your journey to inner peace and mental wellness."
        ),
        OnboardingPage(
            icon: "lungs.fill",
            iconColor: .green,
            title: "Breathing Exercises",
            subtitle: "Find your calm center",
            description: "Learn powerful breathing techniques that activate your body's natural relaxation response. Reduce stress, lower anxiety, and improve focus with guided breathing sessions."
        ),
        OnboardingPage(
            icon: "heart.fill",
            iconColor: .pink,
            title: "Gratitude Journal",
            subtitle: "Cultivate positive mindset",
            description: "Build a daily gratitude practice that transforms your perspective. Record what you're thankful for, track your journey, and develop a lasting appreciation for life's blessings."
        ),
        OnboardingPage(
            icon: "memorychip",
            iconColor: .purple,
            title: "Memory Jar",
            subtitle: "Preserve precious moments",
            description: "Capture and cherish your most meaningful memories. Store photos, videos, and audio recordings of special moments that bring you joy and comfort."
        ),
        OnboardingPage(
            icon: "figure.mind.and.body",
            iconColor: .orange,
            title: "Yoga & Wellness",
            subtitle: "Nurture body and mind",
            description: "Practice gentle yoga poses and mindfulness exercises designed to reduce stress and promote overall well-being. Find balance in movement and stillness."
        ),
        OnboardingPage(
            icon: "music.note",
            iconColor: .indigo,
            title: "Soothing Sounds",
            subtitle: "Create peaceful atmosphere",
            description: "Immerse yourself in calming nature sounds and peaceful melodies. Customize your audio experience to create the perfect environment for relaxation and meditation."
        )
    ]
    
    var body: some View {
        ZStack {
            // Solid background
            Color(.systemBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Skip button
                HStack {
                    Spacer()
                    Button("Skip") {
                        UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
                        isPresented = false
                    }
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(.blue)
                    .padding(.trailing, 20)
                    .padding(.top, 10)
                }
                
                // Page content
                TabView(selection: $currentPage) {
                    ForEach(0..<onboardingPages.count, id: \.self) { index in
                        OnboardingPageView(page: onboardingPages[index])
                            .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .animation(.easeInOut, value: currentPage)
                
                // Bottom navigation
                VStack(spacing: 20) {
                    // Page indicators
                    HStack(spacing: 8) {
                        ForEach(0..<onboardingPages.count, id: \.self) { index in
                            Circle()
                                .fill(index == currentPage ? Color.blue : Color.gray.opacity(0.3))
                                .frame(width: 8, height: 8)
                                .scaleEffect(index == currentPage ? 1.2 : 1.0)
                                .animation(.easeInOut(duration: 0.2), value: currentPage)
                        }
                    }
                    
                    // Navigation buttons
                    HStack(spacing: 16) {
                        if currentPage > 0 {
                            Button("Previous") {
                                withAnimation {
                                    currentPage -= 1
                                }
                            }
                            .font(.system(size: 17, weight: .medium))
                            .foregroundColor(.blue)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 12)
                            .background(Color.blue.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                        }
                        
                        Spacer()
                        
                        Button(currentPage == onboardingPages.count - 1 ? "Get Started" : "Next") {
                            if currentPage == onboardingPages.count - 1 {
                                UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
                                isPresented = false
                            } else {
                                withAnimation {
                                    currentPage += 1
                                }
                            }
                        }
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 32)
                        .padding(.vertical, 14)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.8)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                        .shadow(color: .blue.opacity(0.3), radius: 8, x: 0, y: 4)
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.bottom, 40)
            }
        }
    }
}

struct OnboardingPage: Identifiable {
    let id = UUID()
    let icon: String
    let iconColor: Color
    let title: String
    let subtitle: String
    let description: String
}

struct OnboardingPageView: View {
    let page: OnboardingPage
    
    var body: some View {
        VStack(spacing: 32) {
            Spacer()
            
            // Icon
            Image(systemName: page.icon)
                .font(.system(size: 80, weight: .light))
                .foregroundColor(page.iconColor)
                .padding(.bottom, 20)
            
            // Content
            VStack(spacing: 16) {
                Text(page.title)
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                
                Text(page.subtitle)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                
                Text(page.description)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .padding(.horizontal, 40)
            }
            
            Spacer()
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    Onboarding(isPresented: .constant(true))
}
