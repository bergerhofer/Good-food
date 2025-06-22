import SwiftUI

struct ContentView: View {
    @State private var selectedDate = Date()
    @State private var showWeekly = false

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Toggle Button with more breathing room
                HStack {
                    Spacer()
                    Button(action: { showWeekly.toggle() }) {
                        Text(showWeekly ? "Daily View" : "Weekly View")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 20)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(10)
                    }
                    .padding(.trailing)
                }
                .padding(.top, 16)
                .padding(.bottom, 8)
                .background(Color(.systemBackground))

                if showWeekly {
                    WeeklyView()
                } else {
                    ScrollView {
                        VStack(spacing: 20) {
                            // Date Navigation Header
                            DateNavigationView(selectedDate: $selectedDate)

                            // Header
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Daily Food Tracker")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)

                                Text("Track your daily nutrition goals")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)

                            // Food Tracker Component
                            FoodTracker(selectedDate: selectedDate)
                                .padding(.horizontal)
                        }
                        .padding(.top)
                    }
                    .background(Color(.systemGroupedBackground))
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct WeeklyView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Last 7 days with today at the top in descending order
                ForEach(lastSevenDays(), id: \.self) { day in
                    DayProgressBar(date: day, isToday: Calendar.current.isDateInToday(day))
                }

                Spacer(minLength: 20)
            }
            .padding(.horizontal)
            .padding(.top, 8)
        }
        .background(Color(.systemGroupedBackground))
    }

    private func lastSevenDays() -> [Date] {
        let calendar = Calendar.current
        let today = Date()

        // Get the last 7 days including today, sorted in descending order (today first)
        return (0..<7).compactMap { daysAgo in
            calendar.date(byAdding: .day, value: -daysAgo, to: today)
        }.sorted(by: >) // Sort in descending order (today at top)
    }
}

struct DayProgressBar: View {
    let date: Date
    let isToday: Bool

    @State private var dayData: DayProgressData?

    var body: some View {
        HStack(spacing: 12) {
            // Day label
            VStack(alignment: .leading, spacing: 2) {
                Text(shortDayString(date))
                    .font(.subheadline)
                    .fontWeight(isToday ? .bold : .medium)
                    .foregroundColor(isToday ? .blue : .primary)

                if isToday {
                    Text("TODAY")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 4)
                        .padding(.vertical, 1)
                        .background(Color.blue)
                        .cornerRadius(3)
                }
            }
            .frame(width: 50, alignment: .leading)

            // Progress bar with stacked green and red
            ZStack(alignment: .leading) {
                // Background
                Rectangle()
                    .fill(Color(.systemGray5))
                    .frame(height: 20)
                    .cornerRadius(10)
                if let data = dayData {
                    let totalPercentage = data.greenPercentage + data.redPercentage
                    
                    if totalPercentage > 100 {
                        // If over 100%, show completely red
                        Rectangle()
                            .fill(Color.red)
                            .frame(width: min(CGFloat(totalPercentage) * 0.01 * 200, 200), height: 20)
                            .cornerRadius(10)
                    } else {
                        // Normal case: green up to 100%, red for overage
                        // Green segment (up to 100%)
                        if data.greenPercentage > 0 {
                            Rectangle()
                                .fill(Color.green)
                                .frame(width: min(CGFloat(data.greenPercentage) * 0.01 * 200, 200), height: 20)
                                .cornerRadius(10)
                        }
                        // Red segment (over target), starts after green
                        if data.redPercentage > 0 {
                            Rectangle()
                                .fill(Color.red)
                                .frame(width: CGFloat(data.redPercentage) * 0.01 * 200, height: 20)
                                .offset(x: min(CGFloat(data.greenPercentage) * 0.01 * 200, 200)) // start after green
                        }
                    }
                }
            }
            .frame(width: 200, height: 20)
            .clipped()

            // Percentage text
            Text(percentageText)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(percentageColor)
                .frame(width: 40, alignment: .trailing)

            Spacer()
        }
        .padding(.vertical, 4)
        .onAppear {
            loadDayData()
        }
    }

    private var percentageText: String {
        guard let data = dayData else { return "--%" }
        let totalPercentage = data.greenPercentage + data.redPercentage
        return "\(Int(totalPercentage))%"
    }

    private var percentageColor: Color {
        guard let data = dayData else { return .secondary }
        if data.redPercentage > 0 {
            return .red
        } else if data.greenPercentage >= 100 {
            return .green
        } else {
            return .primary
        }
    }

    private func shortDayString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return formatter.string(from: date)
    }

    private func loadDayData() {
        let normalizedDate = FoodTrackerDataManager.shared.normalizeDate(date)

        if let data = FoodTrackerDataManager.shared.loadData(for: normalizedDate) {
            // Default target counts (the original boxes)
            let defaultProteinCount = 8
            let defaultFruitsCount = 3
            let defaultVegetablesCount = 3
            let defaultCarbsCount = 2
            let defaultDairyCount = 1
            
            let totalDefaultTarget = defaultProteinCount + defaultFruitsCount + defaultVegetablesCount + defaultCarbsCount + defaultDairyCount

            // Count checked items in default boxes only (green)
            let defaultProteinChecked = Array(data.proteinChecked.prefix(defaultProteinCount)).filter { $0 }.count
            let defaultFruitsChecked = Array(data.fruitsChecked.prefix(defaultFruitsCount)).filter { $0 }.count
            let defaultVegetablesChecked = Array(data.vegetablesChecked.prefix(defaultVegetablesCount)).filter { $0 }.count
            let defaultCarbsChecked = Array(data.carbsChecked.prefix(defaultCarbsCount)).filter { $0 }.count
            let defaultDairyChecked = Array(data.dairyChecked.prefix(defaultDairyCount)).filter { $0 }.count

            let totalDefaultChecked = defaultProteinChecked + defaultFruitsChecked + defaultVegetablesChecked + defaultCarbsChecked + defaultDairyChecked

            // Count checked items in added boxes only (red)
            let addedProteinChecked = Array(data.proteinChecked.dropFirst(defaultProteinCount)).filter { $0 }.count
            let addedFruitsChecked = Array(data.fruitsChecked.dropFirst(defaultFruitsCount)).filter { $0 }.count
            let addedVegetablesChecked = Array(data.vegetablesChecked.dropFirst(defaultVegetablesCount)).filter { $0 }.count
            let addedCarbsChecked = Array(data.carbsChecked.dropFirst(defaultCarbsCount)).filter { $0 }.count
            let addedDairyChecked = Array(data.dairyChecked.dropFirst(defaultDairyCount)).filter { $0 }.count

            let totalAddedChecked = addedProteinChecked + addedFruitsChecked + addedVegetablesChecked + addedCarbsChecked + addedDairyChecked

            // Calculate percentages
            let greenPercentage = totalDefaultTarget > 0 ? Double(totalDefaultChecked) / Double(totalDefaultTarget) * 100.0 : 0.0
            let redPercentage = totalDefaultTarget > 0 ? Double(totalAddedChecked) / Double(totalDefaultTarget) * 100.0 : 0.0

            print("Date: \(normalizedDate), defaultTarget: \(totalDefaultTarget), defaultChecked: \(totalDefaultChecked), addedChecked: \(totalAddedChecked), green: \(greenPercentage), red: \(redPercentage)")

            dayData = DayProgressData(
                greenPercentage: greenPercentage, // Don't cap at 100% - let it show over 100%
                redPercentage: redPercentage
            )
        } else {
            dayData = DayProgressData(greenPercentage: 0, redPercentage: 0)
        }
    }
}

struct DayProgressData {
    let greenPercentage: Double
    let redPercentage: Double
}

struct DateNavigationView: View {
    @Binding var selectedDate: Date

    var body: some View {
        VStack(spacing: 12) {
            // Date Display
            HStack {
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        let newDate = Calendar.current.date(byAdding: .day, value: -1, to: selectedDate) ?? selectedDate
                        selectedDate = newDate
                    }
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.blue)
                }

                Spacer()

                VStack(spacing: 4) {
                    Text(dateFormatter.string(from: selectedDate))
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)

                    // Today Badge
                    if Calendar.current.isDateInToday(selectedDate) {
                        Text("TODAY")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 2)
                            .background(Color.blue)
                            .cornerRadius(4)
                    }
                }

                Spacer()

                Button(action: {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        let newDate = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate) ?? selectedDate
                        selectedDate = newDate
                    }
                }) {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                        .foregroundColor(.blue)
                }
            }
            .padding(.horizontal)

            // Today Button - Only show when NOT on today
            if !Calendar.current.isDateInToday(selectedDate) {
                Button("Today") {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        let today = Date()
                        selectedDate = today
                    }
                }
                .buttonStyle(QuickNavButtonStyle(isActive: false))
                .padding(.horizontal)
            }
        }
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
        )
        .padding(.horizontal)
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d"
        return formatter
    }
}

struct QuickNavButtonStyle: ButtonStyle {
    let isActive: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.caption)
            .fontWeight(.medium)
            .foregroundColor(isActive ? .white : .blue)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(isActive ? Color.blue : Color.clear)
            .cornerRadius(8)
            .opacity(configuration.isPressed ? 0.7 : 1.0)
    }
}
