#!/usr/bin/env python3
import os
from PIL import Image, ImageDraw

def create_icon(size):
    """Create a green background with white plate icon"""
    # Create image with green background
    img = Image.new('RGBA', (size, size), (34, 139, 34, 255))  # Forest green
    draw = ImageDraw.Draw(img)
    
    # Calculate plate size (60% of icon size)
    plate_size = int(size * 0.6)
    plate_x = (size - plate_size) // 2
    plate_y = (size - plate_size) // 2
    
    # Draw white plate (circle)
    draw.ellipse([plate_x, plate_y, plate_x + plate_size, plate_y + plate_size], 
                 fill=(255, 255, 255, 255))
    
    return img

def main():
    # Icon sizes needed for iOS
    sizes = [
        (20, "Icon-20.png"),
        (29, "Icon-29.png"),
        (40, "Icon-40.png"),
        (58, "Icon-58.png"),
        (60, "Icon-60.png"),
        (80, "Icon-80.png"),
        (87, "Icon-87.png"),
        (120, "Icon-120.png"),
        (152, "Icon-152.png"),
        (167, "Icon-167.png"),
        (180, "Icon-180.png"),
        (1024, "Icon-1024.png")
    ]
    
    # Create icons directory if it doesn't exist
    icon_dir = "GoodFood/Assets.xcassets/AppIcon.appiconset"
    os.makedirs(icon_dir, exist_ok=True)
    
    # Generate each icon
    for size, filename in sizes:
        print(f"Creating {filename} ({size}x{size})")
        icon = create_icon(size)
        icon_path = os.path.join(icon_dir, filename)
        icon.save(icon_path, "PNG")
    
    print("✅ All app icons created successfully!")
    print(f"Icons saved to: {icon_dir}")

if __name__ == "__main__":
    main() 