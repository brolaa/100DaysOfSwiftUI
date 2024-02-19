//
//  ContentView.swift
//  FaceReminder
//
//  Created by Bartosz Rola on 21/07/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.faces) { face in
                    NavigationLink {
                        DetailView(face: face)
                    } label: {
                        HStack {
                            CircleView(image: DataMangement.loadImage(pathName: face.id.uuidString))
                                .padding(1)
                            
                            Text(face.name)
                        }
                    }
                }
                .onDelete { viewModel.deleteFace(at: $0) } 
            }
            .navigationTitle("FaceReminder")
            .toolbar {
                Button {
                    viewModel.showingAddFace = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $viewModel.showingAddFace) {
                AddFaceView(faces: $viewModel.faces)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
