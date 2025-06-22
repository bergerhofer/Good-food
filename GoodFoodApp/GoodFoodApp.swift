import SwiftUI

// MARK: - Main App
@main
struct GoodFoodApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

// MARK: - Main Content View
struct ContentView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
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
                    FoodTracker()
                        .padding(.horizontal)
                }
                .padding(.top)
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarHidden(true)
        }
    }
}

// MARK: - Food Tracker Component
struct FoodTracker: View {
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
                onAdd: {
                    proteinCount += 1
                    proteinChecked.append(false)
                }
            )
            
            // Fruits Section
            FoodCategorySection(
                title: "Fruits",
                count: fruitsCount,
                checkedItems: $fruitsChecked,
                onAdd: {
                    fruitsCount += 1
                    fruitsChecked.append(false)
                }
            )
            
            // Vegetables Section
            FoodCategorySection(
                title: "Vegetables",
                count: vegetablesCount,
                checkedItems: $vegetablesChecked,
                onAdd: {
                    vegetablesCount += 1
                    vegetablesChecked.append(false)
                }
            )
            
            // Carbs Section
            FoodCategorySection(
                title: "Carbs",
                count: carbsCount,
                checkedItems: $carbsChecked,
                onAdd: {
                    carbsCount += 1
                    carbsChecked.append(false)
                }
            )
            
            // Dairy Section
            FoodCategorySection(
                title: "Dairy",
                count: dairyCount,
                checkedItems: $dairyChecked,
                onAdd: {
                    dairyCount += 1
                    dairyChecked.append(false)
                }
            )
        }
    }
}

// MARK: - Food Category Section
struct FoodCategorySection: View {
    let title: String
    let count: Int
    @Binding var checkedItems: [Bool]
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
                        )
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
    
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.2)) {
                isChecked.toggle()
            }
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(isChecked ? Color.blue : Color(.systemGray6))
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

// MARK: - Preview
#Preview {
    ContentView()
} 