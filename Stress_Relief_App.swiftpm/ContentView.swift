import SwiftUI

struct ContentView: View {
    var body: some View {
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
    }
}
