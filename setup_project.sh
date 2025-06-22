#!/bin/bash

echo "🚀 Setting up GoodFood iOS App..."
echo ""

# Check if Xcode is installed
if ! command -v xcodebuild &> /dev/null; then
    echo "❌ Xcode is not installed or not in PATH"
    echo "Please install Xcode from the App Store first"
    exit 1
fi

echo "✅ Xcode is installed"
echo ""

# Create a new directory for the project
PROJECT_DIR="GoodFoodApp"
if [ -d "$PROJECT_DIR" ]; then
    echo "⚠️  Project directory already exists. Removing..."
    rm -rf "$PROJECT_DIR"
fi

echo "📁 Creating project directory: $PROJECT_DIR"
mkdir -p "$PROJECT_DIR"

# Copy the main app file
echo "📄 Copying GoodFoodApp.swift..."
cp GoodFoodApp.swift "$PROJECT_DIR/"

# Create a simple README
echo "📝 Creating README..."
cat > "$PROJECT_DIR/README.md" << 'EOF'
# GoodFood App

## How to Open in Xcode:

1. Open Xcode
2. Go to File → New → Project
3. Choose "iOS" → "App"
4. Set Product Name: "GoodFood"
5. Choose "SwiftUI" for Interface
6. Choose "Swift" for Language
7. Save the project in the GoodFoodApp folder
8. Replace the contents of the main Swift file with GoodFoodApp.swift
9. Build and Run (⌘+R)

## Features:
- Daily food tracking with 5 categories
- Checkable boxes for each food item
- Add more boxes with + button
- Responsive design
- Smooth animations
EOF

echo ""
echo "✅ Project setup complete!"
echo ""
echo "📋 Next steps:"
echo "1. Xcode should be open now"
echo "2. Go to File → New → Project"
echo "3. Choose 'iOS' → 'App'"
echo "4. Set Product Name: 'GoodFood'"
echo "5. Choose 'SwiftUI' for Interface"
echo "6. Save in the '$PROJECT_DIR' folder"
echo "7. Replace the main Swift file content with GoodFoodApp.swift"
echo "8. Build and Run (⌘+R)"
echo ""
echo "🎉 Your food tracker app will be ready!" 