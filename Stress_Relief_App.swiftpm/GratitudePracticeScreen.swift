//
//  GratitudePracticeScreen.swift
//  Stress_Relief_App
//
//  Created by Aditya Rai on 12/02/25.
//

import SwiftUI

struct GratitudePracticeScreen: View {
    @State private var gratitudeList: [(text: String, date: Date)] = []
    @State private var newGratitude = ""
    @State private var showingAddSheet = false
    @State private var selectedDate = Date()
    @State private var showingCalendar = false
    @State private var showingWelcomePopup = false
    @State private var showingActionSheet = false
    @State private var selectedGratitudeIndex: Int?
    @State private var showingEditSheet = false
    @State private var editingGratitude = ""
    
    private var weekdayFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    // Gratitude Count Badge
                    let todayGratitudes = gratitudeList.filter { Calendar.current.isDate($0.date, inSameDayAs: selectedDate) }
                    if !todayGratitudes.isEmpty {
                        HStack {
                            Spacer()
                            HStack(spacing: 6) {
                                Image(systemName: "heart.fill")
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundColor(.pink)
                                Text("\(todayGratitudes.count) entries today")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.pink)
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.pink.opacity(0.15))
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 8)
                        .padding(.bottom, 12)
                    }

                    // Gratitude Notes List for Selected Date
                    let selectedDateGratitudes = gratitudeList.filter { Calendar.current.isDate($0.date, inSameDayAs: selectedDate) }

                    if selectedDateGratitudes.isEmpty {
                        VStack(spacing: 20) {
                            Spacer()

                            Image(systemName: "note.text")
                                .font(.system(size: 72, weight: .light))
                                .foregroundColor(.pink.opacity(0.7))
                                .padding(.bottom, 8)

                            VStack(spacing: 8) {
                                Text(Calendar.current.isDateInToday(selectedDate) ? "No gratitude notes yet" : "No notes for this date")
                                    .font(.system(size: 22, weight: .medium))
                                    .foregroundColor(.secondary)
                                    .multilineTextAlignment(.center)

                                Text(Calendar.current.isDateInToday(selectedDate) ? "Start your gratitude journey today" : "Add gratitude notes to see them here")
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(.secondary.opacity(0.8))
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 40)
                            }

                            Spacer()
                        }
                        .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.height * 0.55)
                    } else {
                        VStack(spacing: 16) {
                            ForEach(Array(selectedDateGratitudes.enumerated()), id: \.offset) { index, item in
                                GratitudeNoteCard(
                                    text: item.text,
                                    date: item.date,
                                    colorIndex: index % 5,
                                    onLongPress: {
                                        selectedGratitudeIndex = gratitudeList.firstIndex { $0.text == item.text && Calendar.current.isDate($0.date, inSameDayAs: item.date) }
                                        showingActionSheet = true
                                    }
                                )
                                .transition(.asymmetric(
                                    insertion: .scale.combined(with: .opacity),
                                    removal: .scale.combined(with: .opacity)
                                ))
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 40)
                    }
                }
            }
            .navigationTitle("Gratitude Journal")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                // Calendar button — top left
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { showingCalendar = true }) {
                        Image(systemName: "calendar")
                            .foregroundColor(.blue)
                    }
                }
                // Add button — top right (mirrors Mood Booster Jar)
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddSheet = true }) {
                        Image(systemName: "plus")
                            .foregroundColor(.blue)
                    }
                }
            }
            .onAppear {
                if !UserDefaults.standard.bool(forKey: "hasSeenGratitudeWelcome") {
                    showingWelcomePopup = true
                }
            }
            .sheet(isPresented: $showingAddSheet) {
                AddGratitudeSheet(
                    newGratitude: $newGratitude,
                    gratitudeList: $gratitudeList
                )
            }
            .sheet(isPresented: $showingCalendar) {
                GratitudeCalendarSheet(
                    gratitudeList: $gratitudeList,
                    selectedDate: $selectedDate
                )
            }
            .sheet(isPresented: $showingEditSheet) {
                EditGratitudeSheet(
                    editingGratitude: $editingGratitude,
                    gratitudeList: $gratitudeList,
                    selectedIndex: selectedGratitudeIndex
                )
            }
            .fullScreenCover(isPresented: $showingWelcomePopup) {
                GratitudeWelcomePopup()
            }
            .confirmationDialog(
                "Gratitude Options",
                isPresented: $showingActionSheet,
                titleVisibility: .visible
            ) {
                Button("Edit") {
                    if let index = selectedGratitudeIndex {
                        editingGratitude = gratitudeList[index].text
                        showingEditSheet = true
                    }
                }
                Button("Delete", role: .destructive) {
                    deleteGratitude()
                }
                Button("Cancel", role: .cancel) {}
            }
        }
    }
    
    private func deleteGratitude() {
        if let index = selectedGratitudeIndex {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                gratitudeList.remove(at: index)
            }
            selectedGratitudeIndex = nil
        }
    }
}

struct GratitudeCalendarSheet: View {
    @Binding var gratitudeList: [(text: String, date: Date)]
    @Binding var selectedDate: Date
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Gratitude Calendar")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .padding(.top, 20)
                
                // Calendar View
                CalendarView(
                    gratitudeList: gratitudeList,
                    selectedDate: $selectedDate
                )
                .padding(.horizontal, 20)
                
                Spacer()
                
                // Summary
                VStack(spacing: 12) {
                    let totalGratitudes = gratitudeList.count
                    let uniqueDates = Set(gratitudeList.map { Calendar.current.startOfDay(for: $0.date) }).count
                    
                    HStack(spacing: 20) {
                        VStack(spacing: 4) {
                            Text("\(totalGratitudes)")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.blue)
                            Text("Total Entries")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.secondary)
                        }
                        
                        VStack(spacing: 4) {
                            Text("\(uniqueDates)")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.pink)
                            Text("Days Active")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding(.bottom, 20)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing: Button("Done") {
                    dismiss()
                }
                .foregroundColor(.blue)
            )
        }
    }
}

struct CalendarView: View {
    let gratitudeList: [(text: String, date: Date)]
    @Binding var selectedDate: Date
    @State private var currentMonth = Date()
    
    private let calendar = Calendar.current
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()
    
    var body: some View {
        VStack(spacing: 16) {
            // Month Navigation
            HStack {
                Button(action: previousMonth) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.blue)
                }
                
                Spacer()
                
                Text(dateFormatter.string(from: currentMonth))
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.primary)
                
                Spacer()
                
                Button(action: nextMonth) {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.blue)
                }
            }
            .padding(.horizontal, 20)
            
            // Weekday Headers
            HStack(spacing: 0) {
                ForEach(["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"], id: \.self) { day in
                    Text(day)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity)
                }
            }
            
            // Calendar Grid
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 8) {
                ForEach(daysInMonth(), id: \.self) { date in
                    if let date = date {
                        CalendarDayView(
                            date: date,
                            isSelected: calendar.isDate(date, inSameDayAs: selectedDate),
                            hasGratitude: hasGratitudeForDate(date),
                            isToday: calendar.isDateInToday(date)
                        )
                        .onTapGesture {
                            selectedDate = date
                        }
                    } else {
                        Color.clear
                            .frame(height: 40)
                    }
                }
            }
        }
    }
    
    private func daysInMonth() -> [Date?] {
        let startOfMonth = calendar.dateInterval(of: .month, for: currentMonth)?.start ?? currentMonth
        let firstWeekday = calendar.component(.weekday, from: startOfMonth)
        let daysInMonth = calendar.range(of: .day, in: .month, for: currentMonth)?.count ?? 0
        
        var days: [Date?] = []
        
        // Add empty cells for days before the first day of the month
        for _ in 1..<firstWeekday {
            days.append(nil)
        }
        
        // Add all days of the month
        for day in 1...daysInMonth {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: startOfMonth) {
                days.append(date)
            }
        }
        
        return days
    }
    
    private func hasGratitudeForDate(_ date: Date) -> Bool {
        gratitudeList.contains { calendar.isDate($0.date, inSameDayAs: date) }
    }
    
    private func previousMonth() {
        if let newDate = calendar.date(byAdding: .month, value: -1, to: currentMonth) {
            currentMonth = newDate
        }
    }
    
    private func nextMonth() {
        if let newDate = calendar.date(byAdding: .month, value: 1, to: currentMonth) {
            currentMonth = newDate
        }
    }
}

struct CalendarDayView: View {
    let date: Date
    let isSelected: Bool
    let hasGratitude: Bool
    let isToday: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .fill(backgroundColor)
                .frame(width: 40, height: 40)
            
            Text("\(Calendar.current.component(.day, from: date))")
                .font(.system(size: 16, weight: isSelected ? .semibold : .medium))
                .foregroundColor(textColor)
            
            // Gratitude indicator
            if hasGratitude {
                Circle()
                    .fill(Color.pink)
                    .frame(width: 6, height: 6)
                    .offset(x: 12, y: -12)
            }
        }
    }
    
    private var backgroundColor: Color {
        if isSelected {
            return .blue
        } else if isToday {
            return .blue.opacity(0.1)
        } else {
            return .clear
        }
    }
    
    private var textColor: Color {
        if isSelected {
            return .white
        } else if isToday {
            return .blue
        } else {
            return .primary
        }
    }
}

struct GratitudeNoteCard: View {
    let text: String
    let date: Date
    let colorIndex: Int
    let onLongPress: (() -> Void)?
    
    private let colors: [Color] = [
        Color(red: 1.0, green: 0.96, blue: 0.85),  // Light yellow
        Color(red: 0.92, green: 0.96, blue: 1.0),  // Light blue
        Color(red: 1.0, green: 0.92, blue: 0.92),  // Light pink
        Color(red: 0.92, green: 1.0, blue: 0.92),  // Light green
        Color(red: 1.0, green: 0.92, blue: 1.0)    // Light purple
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(text)
                .font(.system(size: 17, weight: .medium, design: .default))
                .foregroundColor(.primary)
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                Text(date, style: .date)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Text(date, style: .time)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.secondary)
            }
        }
        .padding(20)
        .background(colors[colorIndex])
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: 4)
        .overlay(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .stroke(Color.black.opacity(0.04), lineWidth: 1)
        )
        .onLongPressGesture {
            onLongPress?()
        }
    }
}

struct AddGratitudeSheet: View {
    @Binding var newGratitude: String
    @Binding var gratitudeList: [(text: String, date: Date)]
    @Environment(\.dismiss) private var dismiss
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        NavigationView {
            VStack(spacing: 28) {
                VStack(spacing: 20) {
                    Image(systemName: "heart.fill")
                        .font(.system(size: 52, weight: .light))
                        .foregroundColor(.pink)
                    
                    VStack(spacing: 8) {
                        Text("What are you grateful for?")
                            .font(.system(size: 26, weight: .bold, design: .rounded))
                            .multilineTextAlignment(.center)
                        
                        Text("Take a moment to reflect on something positive")
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 24)
                    }
                }
                .padding(.top, 24)
                
                VStack(spacing: 20) {
                    TextField("I'm grateful for...", text: $newGratitude, axis: .vertical)
                        .font(.system(size: 17, weight: .regular))
                        .padding(18)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                        .focused($isTextFieldFocused)
                        .lineLimit(3...6)
                    
                    Button(action: addGratitude) {
                        HStack(spacing: 8) {
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 18, weight: .medium))
                            Text("Add to Journal")
                                .font(.system(size: 18, weight: .semibold))
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.pink, Color.pink.opacity(0.85)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                        .shadow(color: .pink.opacity(0.25), radius: 10, x: 0, y: 4)
                    }
                    .disabled(newGratitude.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    .opacity(newGratitude.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 0.6 : 1.0)
                }
                .padding(.horizontal, 24)
                
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    dismiss()
                }
                .foregroundColor(.blue),
                trailing: Button("Done") {
                    addGratitude()
                }
                .foregroundColor(.blue)
                .disabled(newGratitude.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            )
        }
        .onAppear {
            isTextFieldFocused = true
        }
    }
    
    private func addGratitude() {
        let trimmedText = newGratitude.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmedText.isEmpty {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                gratitudeList.append((text: trimmedText, date: Date()))
            }
            newGratitude = ""
            dismiss()
        }
    }
}

struct EditGratitudeSheet: View {
    @Binding var editingGratitude: String
    @Binding var gratitudeList: [(text: String, date: Date)]
    @Environment(\.dismiss) private var dismiss
    @FocusState private var isTextFieldFocused: Bool
    let selectedIndex: Int?
    
    var body: some View {
        NavigationView {
            VStack(spacing: 28) {
                VStack(spacing: 20) {
                    Image(systemName: "heart.fill")
                        .font(.system(size: 52, weight: .light))
                        .foregroundColor(.pink)
                    
                    VStack(spacing: 8) {
                        Text("Edit Gratitude Note")
                            .font(.system(size: 26, weight: .bold, design: .rounded))
                            .multilineTextAlignment(.center)
                        
                        Text("Modify your gratitude note")
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 24)
                    }
                }
                .padding(.top, 24)
                
                VStack(spacing: 20) {
                    TextField("I'm grateful for...", text: $editingGratitude, axis: .vertical)
                        .font(.system(size: 17, weight: .regular))
                        .padding(18)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                        .focused($isTextFieldFocused)
                        .lineLimit(3...6)
                    
                    Button(action: saveEditedGratitude) {
                        HStack(spacing: 8) {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 18, weight: .medium))
                            Text("Save Changes")
                                .font(.system(size: 18, weight: .semibold))
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.pink, Color.pink.opacity(0.85)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                        .shadow(color: .pink.opacity(0.25), radius: 10, x: 0, y: 4)
                    }
                    .disabled(editingGratitude.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    .opacity(editingGratitude.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 0.6 : 1.0)
                }
                .padding(.horizontal, 24)
                
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    dismiss()
                }
                .foregroundColor(.blue),
                trailing: Button("Done") {
                    saveEditedGratitude()
                }
                .foregroundColor(.blue)
                .disabled(editingGratitude.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            )
        }
        .onAppear {
            isTextFieldFocused = true
        }
    }
    
    private func saveEditedGratitude() {
        let trimmedText = editingGratitude.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmedText.isEmpty, let index = selectedIndex, index < gratitudeList.count {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                gratitudeList[index] = (text: trimmedText, date: gratitudeList[index].date)
            }
            dismiss()
        }
    }
}

struct GratitudeWelcomePopup: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 32) {
                    // Header
                    VStack(spacing: 16) {
                        Image(systemName: "heart.fill")
                            .font(.system(size: 60, weight: .light))
                            .foregroundColor(.pink)
                        
                        Text("Welcome to Gratitude Journal!")
                            .font(.system(size: 25, weight: .semibold, design: .rounded))
                            .multilineTextAlignment(.center)
                        
                        Text("Your personal space to reflect on life's blessings")
                            .font(.system(size: 18, weight: .regular))
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 32)
                    }
                    .padding(.top, 20)
                    
                    // Features
                    VStack(spacing: 24) {
                        FeatureRow(
                            icon: "plus.circle.fill",
                            iconColor: .blue,
                            title: "Daily Gratitude Entries",
                            description: "Add gratitude notes throughout your day. Each entry is saved with the current date and time."
                        )
                        
                        FeatureRow(
                            icon: "calendar",
                            iconColor: .green,
                            title: "Calendar View",
                            description: "Tap the calendar icon to view all your gratitude entries by date. Navigate between months and see which days have entries."
                        )
                        
                        FeatureRow(
                            icon: "clock.arrow.circlepath",
                            iconColor: .orange,
                            title: "Date Navigation",
                            description: "View gratitude from any previous date. Your entries are organized chronologically for easy access."
                        )
                        
                        FeatureRow(
                            icon: "heart.fill",
                            iconColor: .pink,
                            title: "Personal Growth",
                            description: "Track your gratitude journey over time. See how many entries you've made each day and build a positive mindset."
                        )
                    }
                    .padding(.horizontal, 24)
                    
                    // Continue Button
                    Button(action: {
                        UserDefaults.standard.set(true, forKey: "hasSeenGratitudeWelcome")
                        dismiss()
                    }) {
                        Text("Get Started")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 18)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.85)]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(color: .blue.opacity(0.25), radius: 10, x: 0, y: 4)
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 20)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing: Button("Skip") {
                    UserDefaults.standard.set(true, forKey: "hasSeenGratitudeWelcome")
                    dismiss()
                }
                .foregroundColor(.blue)
            )
        }
    }
}

struct FeatureRow: View {
    let icon: String
    let iconColor: Color
    let title: String
    let description: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 24, weight: .medium))
                .foregroundColor(iconColor)
                .frame(width: 32)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.primary)
                
                Text(description)
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.secondary)
                    .lineLimit(nil)
                    .multilineTextAlignment(.leading)
            }
            
            Spacer()
        }
        .padding(20)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
}

#Preview {
    GratitudePracticeScreen()
}




