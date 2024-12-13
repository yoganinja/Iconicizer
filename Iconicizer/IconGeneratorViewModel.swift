//
//  IconGeneratorViewModel.swift
//  Iconicizer
//
//  Created by John Florian on 12/13/24.
//

import Foundation
import AppKit

class IconGeneratorViewModel: ObservableObject {
  @Published var selectedImage: NSImage?
  @Published var message: String = ""
  @Published var showFilePicker: Bool = false
  
  func handleFileSelection(result: Result<[URL], Error>) {
    switch result {
    case .success(let urls):
      guard let url = urls.first else { return }
      do {
        if url.startAccessingSecurityScopedResource() {
          defer { url.stopAccessingSecurityScopedResource() }
          if let image = NSImage(contentsOf: url) {
            self.selectedImage = image
            self.message = "Image loaded successfully!"
          } else {
            self.message = "Failed to load image from URL."
          }
        } else {
          self.message = "Permission denied to access the file."
        }
      }
    case .failure(let error):
      self.message = "Error selecting file: \(error.localizedDescription)"
    }
  }
  
  func selectOutputDirectory() -> URL? {
    let panel = NSOpenPanel()
    panel.canChooseDirectories = true
    panel.canChooseFiles = false
    panel.allowsMultipleSelection = false
    panel.prompt = "Select Output Directory"
    
    return panel.runModal() == .OK ? panel.url : nil
  }
  
  func generateIcons(appType: AppType) {
    guard let image = selectedImage else {
      self.message = "Please select an image first."
      return
    }
    
    guard let outputDirectory = selectOutputDirectory(),
          outputDirectory.startAccessingSecurityScopedResource() else {
      self.message = "Output directory not selected."
      return
    }
    defer { outputDirectory.stopAccessingSecurityScopedResource() }
    
    do {
      for size in appType.iconSizes {
        for scale in appType.scaleFactors {
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
      self.message = "Icons generated successfully at \(outputDirectory.path)."
    } catch {
      self.message = "Error generating icons: \(error.localizedDescription)"
    }
  }
  
  private func pngData(from image: NSImage) -> Data? {
    guard let tiffData = image.tiffRepresentation,
          let bitmapImageRep = NSBitmapImageRep(data: tiffData) else {
      return nil
    }
    return bitmapImageRep.representation(using: .png, properties: [:])
  }
  
  private func resizeImage(_ image: NSImage, to size: CGSize) -> NSImage? {
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
    
    NSGraphicsContext.saveGraphicsState()
    NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: bitmapRep)
    
    let rect = CGRect(origin: .zero, size: size)
    image.draw(in: rect, from: .zero, operation: .sourceOver, fraction: 1.0)
    
    NSGraphicsContext.restoreGraphicsState()
    
    let resizedImage = NSImage(size: size)
    resizedImage.addRepresentation(bitmapRep)
    
    return resizedImage
  }
}
