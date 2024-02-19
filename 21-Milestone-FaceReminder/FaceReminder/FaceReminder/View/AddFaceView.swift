//
//  AddFaceView.swift
//  FaceReminder
//
//  Created by Bartosz Rola on 21/07/2023.
//

import SwiftUI

struct AddFaceView: View {
    @StateObject private var viewModel: ViewModel
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter name", text: $viewModel.name)
                    .padding(.bottom)
                
                ZStack {
                    Rectangle()
                        .fill(.gray)
                    Text("Tap to add photo")
                        .foregroundColor(.white)
                    viewModel.image?
                        .resizable()
                        .scaledToFit()
                }
                .aspectRatio(1, contentMode: .fit)
                .onTapGesture {
                    viewModel.showingImagePicker = true
                }
                .cornerRadius(20)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Add face")
            .sheet(isPresented: $viewModel.showingImagePicker) {
                ImagePicker(image: $viewModel.inputImage)
            }
            .onChange(of: viewModel.inputImage) { _ in viewModel.loadImage() }
            .toolbar {
                Button("Save") {
                    viewModel.saveFace()
                    dismiss()
                }
                .disabled(viewModel.validateData())
            }
            .onAppear {
                viewModel.locationFetcher.start()
            }
        }
    }
    
    init(faces: Binding<[Face]>) {
        _viewModel = StateObject(wrappedValue: ViewModel(faces: faces))
    }
}

struct AddFaceView_Previews: PreviewProvider {
    static let faces = [Face]()
    
    static var previews: some View {
        AddFaceView(faces: .constant(faces))
    }
}
