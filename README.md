# GoodFood - Daily Food Tracker

A minimal, mobile-friendly daily food tracker component for a health app built with SwiftUI.

## Features

The app displays five food categories with customizable tracking boxes:

- **Protein** (default: 8 boxes)
- **Fruits** (default: 3 boxes) 
- **Vegetables** (default: 3 boxes)
- **Carbs** (default: 2 boxes)
- **Dairy** (default: 1 box)

### Key Features

✅ **Section Titles**: Each food category has a clear section title

✅ **Checkable Boxes**: Tap to toggle boxes on/off with smooth animations

✅ **Minimum Touch Targets**: All boxes are 44px minimum height/width for accessibility

✅ **Add More Boxes**: "+" button at the end of each section to add additional boxes

✅ **Responsive Layout**: Boxes wrap to new lines and adapt to different screen sizes

✅ **Clean Design**: Soft shadows, gentle spacing, and modern iOS design patterns

✅ **Expandable**: Supports unlimited expansion as users add more boxes per food group

## Quick Start

### Option 1: Use the Standalone File (Recommended)

1. Open Xcode
2. Create a new iOS App project (File → New → Project → iOS → App)
3. Replace the contents of your main Swift file with the code from `GoodFoodApp.swift`
4. Build and run (⌘+R)

### Option 2: Create New Project Manually

1. Open Xcode
2. Create a new iOS App project
3. Choose "App" under iOS
4. Set your project name (e.g., "GoodFood")
5. Choose "SwiftUI" for interface
6. Copy the code from `GoodFoodApp.swift` into your main app file
7. Build and run

## Technical Implementation

- **SwiftUI**: Modern declarative UI framework
- **LazyVGrid**: Efficient grid layout that wraps boxes to new lines
- **State Management**: Uses `@State` for reactive UI updates
- **Animations**: Smooth transitions when toggling boxes
- **Accessibility**: Proper touch targets and semantic structure

## File Structure

```
GoodFood/
├── GoodFoodApp.swift          # Complete app in one file
├── README.md                  # This file
└── GoodFood.xcodeproj/        # Xcode project (optional)
```

## Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 5.0+

## Design Principles

- **Minimal**: Clean, uncluttered interface
- **Mobile-First**: Optimized for touch interaction
- **Accessible**: Proper touch targets and visual feedback
- **Responsive**: Adapts to different screen sizes and orientations
- **Modern**: Uses latest iOS design patterns and SwiftUI features

## Troubleshooting

If you encounter issues:

1. Make sure you're using Xcode 15.0 or later
2. Ensure your deployment target is iOS 17.0 or later
3. Try creating a fresh project and copying just the Swift code
4. The standalone `GoodFoodApp.swift` file contains everything needed 