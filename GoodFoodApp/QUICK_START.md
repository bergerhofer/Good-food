# 🚀 Quick Start Guide - GoodFood App

## Step-by-Step Instructions

### 1. Create New Xcode Project
- Xcode should already be open
- Click **File** → **New** → **Project**
- Select **iOS** tab
- Choose **App** template
- Click **Next**

### 2. Configure Project
- **Product Name**: `GoodFood`
- **Team**: Your personal team (or leave default)
- **Organization Identifier**: `com.yourname` (or leave default)
- **Interface**: **SwiftUI** ⭐ (Important!)
- **Language**: **Swift**
- **Use Core Data**: ❌ (Uncheck)
- **Include Tests**: ❌ (Uncheck)
- Click **Next**

### 3. Save Project
- Choose the **GoodFoodApp** folder we created
- Click **Create**

### 4. Replace Code
- In the project navigator, find your main app file (usually named `GoodFoodApp.swift` or similar)
- Select all the code (⌘+A)
- Delete it (Delete key)
- Open the `GoodFoodApp.swift` file in the GoodFoodApp folder
- Copy all the code (⌘+A, then ⌘+C)
- Paste it into your main app file (⌘+V)

### 5. Build and Run
- Select a simulator (iPhone 15, etc.)
- Click the **Play** button or press **⌘+R**

## 🎉 You're Done!

Your food tracker app should now be running with:
- ✅ 5 food categories (Protein, Fruits, Vegetables, Carbs, Dairy)
- ✅ Checkable boxes for each category
- ✅ "+" buttons to add more boxes
- ✅ Responsive design
- ✅ Smooth animations

## Troubleshooting

**If you get build errors:**
- Make sure you selected **SwiftUI** for the interface
- Ensure iOS deployment target is 17.0 or later
- Try cleaning the build folder (Product → Clean Build Folder)

**If the app doesn't look right:**
- Make sure you copied ALL the code from GoodFoodApp.swift
- Check that you're running on iOS 17+ simulator

## Features You'll See

1. **Header**: "Daily Food Tracker" with subtitle
2. **Protein Section**: 8 boxes (default)
3. **Fruits Section**: 3 boxes (default)
4. **Vegetables Section**: 3 boxes (default)
5. **Carbs Section**: 2 boxes (default)
6. **Dairy Section**: 1 box (default)

Each section has:
- A clear title
- Checkable boxes (tap to toggle)
- A "+" button to add more boxes
- Clean, modern design with shadows 