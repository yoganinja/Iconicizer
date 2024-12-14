# Iconicizer

**Iconicizer** is a macOS app built with **SwiftUI** that allows developers and designers to generate icons for iOS and macOS applications. The app simplifies the process of creating app icon sets by resizing images to the required dimensions for submission to the App Store.

---

## Features

- **Easy Image Import**: Drag and drop or use the file picker to load your source image.
- **Generate App Icons**:
  - iOS icons: Automatically generate all required sizes for iPhone and iPad.
  - macOS icons: Create icons with dimensions optimized for macOS applications.
- **Export to Directory**: Select an output directory and export icons directly in `.png` format.
- **Error Handling**: Notifies users of issues like missing source images or permissions errors.
- **SwiftUI-powered**: Built using modern SwiftUI principles for macOS apps.

---

## Screenshots

### Main Interface:
![Iconicizer Main UI](path/to/screenshot1.png)

### Icon Generation:
![Iconicizer Export Example](path/to/screenshot2.png)

---

## Requirements

- **macOS**: macOS 12.0 (Monterey) or later
- **Xcode**: Version 14.0 or later
- **Programming Language**: Swift 6.0
- **Build Tools**: SwiftUI

---

## Installation

### Clone the Repository
```bash
git clone https://github.com/yourusername/Iconicizer.git
cd Iconicizer
```

### Build and Run in Xcode
1. Open `Iconicizer.xcodeproj` in Xcode.
2. Select your target (`My Mac`).
3. Click the **Run** button (`⌘R`) to build and launch the app.

---

## How to Use

1. Launch the **Iconicizer** app.
2. Click **Select Image** to load your source image.
   - Ensure the image is at least **1024x1024 pixels** for optimal results.
3. Click **Generate Icons** to create app icons for iOS or macOS.
4. Select an output directory when prompted.
5. The app generates icons in the appropriate sizes and scales and saves them to the specified directory.

---

## iOS and macOS Icon Specifications

### iOS Icons:
| Size (pt) | Scale | Pixel Dimensions (px) |
|-----------|-------|-----------------------|
| 20x20     | @1x   | 20x20                 |
| 20x20     | @2x   | 40x40                 |
| 20x20     | @3x   | 60x60                 |
| 29x29     | @1x   | 29x29                 |
| 29x29     | @2x   | 58x58                 |
| 29x29     | @3x   | 87x87                 |
| 40x40     | @1x   | 40x40                 |
| 40x40     | @2x   | 80x80                 |
| 40x40     | @3x   | 120x120               |
| 60x60     | @1x   | 60x60                 |
| 60x60     | @2x   | 120x120               |
| 60x60     | @3x   | 180x180               |
| 76x76     | @1x   | 76x76                 |
| 76x76     | @2x   | 152x152               |
| 76x76     | @3x   | 228x228               |
| 83.5x83.5 | @1x   | 83.5x83.5             |
| 83.5x83.5 | @2x   | 167x167               |
| 83.5x83.5 | @3x   | 250.5x250.5           |
| 1024x1024 | @1x   | 1024x1024             |

### macOS Icons:
| Size (pt) | Scale | Pixel Dimensions (px) |
|-----------|-------|-----------------------|
| 16x16     | @1x   | 16x16                 |
| 16x16     | @2x   | 32x32                 |
| 32x32     | @1x   | 32x32                 |
| 32x32     | @2x   | 64x64                 |
| 128x128   | @1x   | 128x128               |
| 128x128   | @2x   | 256x256               |
| 256x256   | @1x   | 256x256               |
| 256x256   | @2x   | 512x512               |
| 512x512   | @1x   | 512x512               |
| 512x512   | @2x   | 1024x1024             |

---

## Contributing

Contributions are welcome! Please follow these steps to contribute:

1. **Fork the repository**.
2. **Create a feature branch**:
   ```bash
   git checkout -b feature/my-feature
   ```
3. **Commit your changes**:
   ```bash
   git commit -m "Add a new feature"
   ```
4. **Push to your branch**:
   ```bash
   git push origin feature/my-feature
   ```
5. **Open a Pull Request**.

---

## Roadmap

### Planned Features:
- Support for watchOS and tvOS app icons.
- Drag-and-drop support for loading images.
- Save presets for frequently used export directories.

---

## License

This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for details.

---

## Contact

For questions or feedback, please contact:

- **Author**: John Florian
- **Email**: im2bz46@gmail.com
- **GitHub**: [@yoganinja](https://github.com/yoganinja)
