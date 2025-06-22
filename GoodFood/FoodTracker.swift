import SwiftUI

// MARK: - Food Tracker Component
struct FoodTracker: View {
    let selectedDate: Date
    
    @State private var proteinCount = 8
    @State private var fruitsCount = 3
    @State private var vegetablesCount = 3
    @State private var carbsCount = 2
    @State private var dairyCount = 1
    
    @State private var proteinChecked: [Bool] = Array(repeating: false, count: 8)
    @State private var fruitsChecked: [Bool] = Array(repeating: false, count: 3)
    @State private var vegetablesChecked: [Bool] = Array(repeating: false, count: 3)
    @State private var carbsChecked: [Bool] = Array(repeating: false, count: 2)
    @State private var dairyChecked: [Bool] = Array(repeating: false, count: 1)
    
    var body: some View {
        VStack(spacing: 24) {
            // Protein Section
            FoodCategorySection(
                title: "Protein",
                count: proteinCount,
                checkedItems: $proteinChecked,
                defaultCount: 8,
                onAdd: {
                    proteinCount += 1
                    proteinChecked.append(false)
                    saveData()
                }
            )
            
            // Fruits Section
            FoodCategorySection(
                title: "Fruits",
                count: fruitsCount,
                checkedItems: $fruitsChecked,
                defaultCount: 3,
                onAdd: {
                    fruitsCount += 1
                    fruitsChecked.append(false)
                    saveData()
                }
            )
            
            // Vegetables Section
            FoodCategorySection(
                title: "Vegetables",
                count: vegetablesCount,
                checkedItems: $vegetablesChecked,
                defaultCount: 3,
                onAdd: {
                    vegetablesCount += 1
                    vegetablesChecked.append(false)
                    saveData()
                }
            )
            
            // Carbs Section
            FoodCategorySection(
                title: "Carbs",
                count: carbsCount,
                checkedItems: $carbsChecked,
                defaultCount: 2,
                onAdd: {
                    carbsCount += 1
                    carbsChecked.append(false)
                    saveData()
                }
            )
            
            // Dairy Section
            FoodCategorySection(
                title: "Dairy",
                count: dairyCount,
                checkedItems: $dairyChecked,
                defaultCount: 1,
                onAdd: {
                    dairyCount += 1
                    dairyChecked.append(false)
                    saveData()
                }
            )
        }
        .onAppear {
            loadData()
        }
        .onChange(of: selectedDate) { _ in
            loadData()
        }
    }
    
    // MARK: - Data Persistence
    private func saveData() {
        let data = FoodTrackerData(
            date: selectedDate,
            proteinCount: proteinCount,
            fruitsCount: fruitsCount,
            vegetablesCount: vegetablesCount,
            carbsCount: carbsCount,
            dairyCount: dairyCount,
            proteinChecked: proteinChecked,
            fruitsChecked: fruitsChecked,
            vegetablesChecked: vegetablesChecked,
            carbsChecked: carbsChecked,
            dairyChecked: dairyChecked
        )
        
        FoodTrackerDataManager.shared.saveData(data)
    }
    
    private func loadData() {
        if let data = FoodTrackerDataManager.shared.loadData(for: selectedDate) {
            proteinCount = data.proteinCount
            fruitsCount = data.fruitsCount
            vegetablesCount = data.vegetablesCount
            carbsCount = data.carbsCount
            dairyCount = data.dairyCount
            proteinChecked = data.proteinChecked
            fruitsChecked = data.fruitsChecked
            vegetablesChecked = data.vegetablesChecked
            carbsChecked = data.carbsChecked
            dairyChecked = data.dairyChecked
        } else {
            // Reset to defaults for new date
            proteinCount = 8
            fruitsCount = 3
            vegetablesCount = 3
            carbsCount = 2
            dairyCount = 1
            proteinChecked = Array(repeating: false, count: 8)
            fruitsChecked = Array(repeating: false, count: 3)
            vegetablesChecked = Array(repeating: false, count: 3)
            carbsChecked = Array(repeating: false, count: 2)
            dairyChecked = Array(repeating: false, count: 1)
        }
    }
}

// MARK: - Food Category Section
struct FoodCategorySection: View {
    let title: String
    let count: Int
    @Binding var checkedItems: [Bool]
    let defaultCount: Int
    let onAdd: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Section Title
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            // Boxes Container
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 6), spacing: 8) {
                ForEach(0..<count, id: \.self) { index in
                    FoodBox(
                        isChecked: Binding(
                            get: { index < checkedItems.count ? checkedItems[index] : false },
                            set: { newValue in
                                if index < checkedItems.count {
                                    checkedItems[index] = newValue
                                }
                            }
                        ),
                        isDefaultBox: index < defaultCount
                    )
                }
                
                // Add Button
                AddButton(onTap: onAdd)
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
        )
    }
}

// MARK: - Food Box Component
struct FoodBox: View {
    @Binding var isChecked: Bool
    let isDefaultBox: Bool
    
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.2)) {
                isChecked.toggle()
            }
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(boxColor)
                    .frame(minWidth: 44, minHeight: 44)
                    .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
                
                if isChecked {
                    Image(systemName: "checkmark")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private var boxColor: Color {
        if isChecked {
            return isDefaultBox ? Color.green : Color.red
        } else {
            return Color(.systemGray6)
        }
    }
}

// MARK: - Add Button Component
struct AddButton: View {
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(.systemGray5))
                    .frame(minWidth: 44, minHeight: 44)
                    .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
                
                Image(systemName: "plus")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.blue)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Data Models
struct FoodTrackerData: Codable {
    let date: Date
    let proteinCount: Int
    let fruitsCount: Int
    let vegetablesCount: Int
    let carbsCount: Int
    let dairyCount: Int
    let proteinChecked: [Bool]
    let fruitsChecked: [Bool]
    let vegetablesChecked: [Bool]
    let carbsChecked: [Bool]
    let dairyChecked: [Bool]
}

// MARK: - Data Manager
class FoodTrackerDataManager: ObservableObject {
    static let shared = FoodTrackerDataManager()
    
    private let userDefaults = UserDefaults.standard
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    private init() {}
    
    func saveData(_ data: FoodTrackerData) {
        let key = "foodTracker_\(dateFormatter.string(from: data.date))"
        if let encoded = try? JSONEncoder().encode(data) {
            userDefaults.set(encoded, forKey: key)
        }
    }
    
    func loadData(for date: Date) -> FoodTrackerData? {
        let key = "foodTracker_\(dateFormatter.string(from: date))"
        guard let data = userDefaults.data(forKey: key),
              let decoded = try? JSONDecoder().decode(FoodTrackerData.self, from: data) else {
            return nil
        }
        return decoded
    }
}

#Preview {
    FoodTracker(selectedDate: Date())
        .padding()
        .background(Color(.systemGroupedBackground))
}
