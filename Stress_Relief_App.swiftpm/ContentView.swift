import SwiftUI

struct ContentView: View {
    @State private var showingOnboarding = false
    
    var body: some View {
        ZStack {
            TabView{
                HomeScreen().tabItem{
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                
                GratitudePracticeScreen().tabItem {
                    Image(systemName: "heart.fill")
                    Text("Gratitude")
                }
                MemoryJarScreen().tabItem {
                    Image(systemName: "archivebox.fill")
                    Text("Memory Jar")
                }
            }
            
            // Full screen onboarding overlay
            if showingOnboarding {
                Onboarding(isPresented: $showingOnboarding)
                    .transition(.opacity)
                    .zIndex(1)
            }
        }
        .onAppear {
            // Check if user has seen onboarding
            if !UserDefaults.standard.bool(forKey: "hasSeenOnboarding") {
                withAnimation(.easeInOut(duration: 0.3)) {
                    showingOnboarding = true
                }
            }
        }
    }
}
