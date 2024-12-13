//
//  ContentView.swift
//  Iconicizer
//
//  Created by John Florian on 12/13/24.
//

import SwiftUI

struct ContentView: View {
  @State private var selectedImage: NSImage? = nil
  @State private var showFilePicker = false
  @State private var outputPath: URL? = nil
  @State private var message = ""
  
  let iconSizes: [CGFloat] = [20, 29, 40, 60, 76, 83.5, 1024]
  let scaleFactors: [CGFloat] = [1, 2, 3] // For @1x, @2x, @3x
  
  var body: some View {
    VStack {
      Text("Iconicizer")
        .font(.title)
        .padding()
      
      if let selectedImage = selectedImage {
        Image(nsImage: selectedImage)
          .resizable()
          .scaledToFit()
          .frame(width: 200, height: 200)
          .border(Color.gray, width: 1)
      } else {
        Text("No image selected")
          .foregroundColor(.gray)
      }
      
      Button("Select Image") {
        showFilePicker = true
      }
      .padding()
      
      Button("Generate Icons") {
        guard let selectedImage = selectedImage else {
          message = "Please select an image first."
          return
        }
        generateIcons(from: selectedImage)
      }
      .padding()
      .disabled(selectedImage == nil)
      
      if !message.isEmpty {
        Text(message)
          .foregroundColor(.green)
          .padding()
      }
    }
    .padding()
    .fileImporter(
      isPresented: $showFilePicker,
      allowedContentTypes: [.image],
      allowsMultipleSelection: false
    ) { result in
      switch result {
      case .success(let urls):
        if let url = urls.first {
          do {
            // Start accessing the security-scoped resource
            if url.startAccessingSecurityScopedResource() {
              defer { url.stopAccessingSecurityScopedResource() }
              
              if let image = NSImage(contentsOf: url) {
                selectedImage = image
                message = "Image loaded successfully!"
              } else {
                message = "Failed to load image from URL."
              }
            } else {
              message = "Permission denied to access the file."
            }
          }
        }
      case .failure(let error):
        message = "Error selecting file: \(error.localizedDescription)"
      }
    }
  }
  
  func selectOutputDirectory() -> URL? {
      let panel = NSOpenPanel()
      panel.canChooseDirectories = true
      panel.canChooseFiles = false
      panel.allowsMultipleSelection = false
      panel.prompt = "Select Output Directory"

      if panel.runModal() == .OK {
          return panel.url
      }
      return nil
  }

  func pngData(from image: NSImage) -> Data? {
    guard let tiffData = image.tiffRepresentation,
          let bitmapImageRep = NSBitmapImageRep(data: tiffData) else {
      return nil
    }
    return bitmapImageRep.representation(using: .png, properties: [:])
  }

  func generateIcons(from image: NSImage) {
    if let outputDirectory = selectOutputDirectory(),
       outputDirectory.startAccessingSecurityScopedResource() {
      defer { outputDirectory.stopAccessingSecurityScopedResource() }
      
        do {
          for size in iconSizes {
            for scale in scaleFactors {
              let pixelSize = size * scale
              let iconSize = CGSize(width: pixelSize, height: pixelSize)

              if let resizedImage = resizeImage(image, to: iconSize),
                 let pngData = pngData(from: resizedImage) {
                  let fileName = "Icon-\(Int(size))@\(Int(scale))x.png"
                let fileURL = outputDirectory.appendingPathComponent(fileName)
                
                try pngData.write(to: fileURL)
              }
            }
          }
          message = "Icons generated successfully at \(outputDirectory.path)."
        } catch {
          message = "Error generating icons: \(error.localizedDescription)"
        }
        
    } else {
      print("Output directory not selected.")
    }
    
  }
  
  func resizeImage(_ image: NSImage, to size: CGSize) -> NSImage? {
      // Create a bitmap representation with the exact pixel size
      guard let bitmapRep = NSBitmapImageRep(
          bitmapDataPlanes: nil,
          pixelsWide: Int(size.width),
          pixelsHigh: Int(size.height),
          bitsPerSample: 8,
          samplesPerPixel: 4,
          hasAlpha: true,
          isPlanar: false,
          colorSpaceName: .deviceRGB,
          bytesPerRow: 0,
          bitsPerPixel: 0
      ) else {
          return nil
      }

      // Set up a graphics context with the bitmap representation
      NSGraphicsContext.saveGraphicsState()
      NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: bitmapRep)

      // Draw the image into the context
      let rect = CGRect(origin: .zero, size: size)
      image.draw(in: rect, from: .zero, operation: .sourceOver, fraction: 1.0)

      // Restore graphics context
      NSGraphicsContext.restoreGraphicsState()

      // Create a new NSImage from the bitmap representation
      let resizedImage = NSImage(size: size)
      resizedImage.addRepresentation(bitmapRep)

      return resizedImage
  }

  func saveImage(_ image: NSImage, to url: URL) throws {
    guard let tiffData = image.tiffRepresentation,
          let bitmapImage = NSBitmapImageRep(data: tiffData),
          let pngData = bitmapImage.representation(using: .png, properties: [:]) else {
      throw NSError(domain: "ImageError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to convert image to PNG"])
    }
    try pngData.write(to: url)
  }
}

#Preview {
  ContentView()
}
