//
//  DetailView.swift
//  FaceReminder
//
//  Created by Bartosz Rola on 22/07/2023.
//

import SwiftUI
import MapKit

struct DetailView: View {
    @StateObject private var viewModel: ViewModel
    
    var body: some View {
        ScrollView {
            if viewModel.image != nil {
                viewModel.image?
                    .resizable()
                    .scaledToFit()
            } else {
                ZStack {
                    Rectangle()
                        .fill(.gray)
                        .frame(height: 300)
                    Text("No Image")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                }
            }
            
            if viewModel.face.coordinate != nil {
                VStack(alignment: .leading) {
                    Divider()
                    
                    Text("Location")
                        .font(.headline)
                    
                    Map(coordinateRegion: $viewModel.region, annotationItems: [viewModel.face]) {
                        MapMarker(coordinate: $0.coordinate!)
                    }
                        .cornerRadius(20)
                        .aspectRatio(1, contentMode: .fit)
                    
                }
                .padding()
            }
            
        }
        .navigationTitle(viewModel.face.name)
    }
    
    init(face: Face) {
        _viewModel = StateObject(wrappedValue: ViewModel(face: face))
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(face: Face.example)
    }
}
