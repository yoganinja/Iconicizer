//
//  IconGeneratorView.swift
//  Iconicizer
//
//  Created by John Florian on 12/13/24.
//

import SwiftUI

struct IconGeneratorView: View {
  @StateObject private var viewModel = IconGeneratorViewModel()
  @State private var appType: AppType = .iOS
  
  var body: some View {
    VStack {
      Text("Iconicizer")
        .font(.title)
        .padding()
      
      if let selectedImage = viewModel.selectedImage {
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
        viewModel.showFilePicker = true
      }
      .padding()
      
      HStack {
        Picker("App Type", selection: $appType) {
          ForEach(AppType.allCases) { type in
            Text(type.rawValue).tag(type)
          }
        }
        .frame(width: 150)
        .pickerStyle(SegmentedPickerStyle())
        
        Button("Generate Icons") {
          viewModel.generateIcons(appType: appType)
        }
        .padding()
        .disabled(viewModel.selectedImage == nil)
      }
      if !viewModel.message.isEmpty {
        Text(viewModel.message)
          .foregroundColor(.green)
          .padding()
      }
    }
    .padding()
    .fileImporter(
      isPresented: $viewModel.showFilePicker,
      allowedContentTypes: [.image],
      allowsMultipleSelection: false,
      onCompletion: viewModel.handleFileSelection
    )
  }
}

#Preview {
  IconGeneratorView()
}
