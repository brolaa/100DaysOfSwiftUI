//
//  EditView.swift
//  BucketList
//
//  Created by Bartosz Rola on 02/05/2023.
//

import SwiftUI

struct EditView: View {
    enum LoadingState {
        case loading, loaded, failed
    }
    
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: ViewModel
    
    var onSave: (Location) -> Void
    var onDelete: (Location) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place name", text: $viewModel.name)
                    TextField("Description", text: $viewModel.description)
                }
                
                Section("Nearby…") {
                    switch viewModel.loadingState {
                    case .loading:
                        Text("Loading…")
                    case .loaded:
                        ForEach(viewModel.pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ")
                            + Text(page.description)
                                .italic()
                        }
                    case .failed:
                        Text("Please try again later.")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let newLocation = viewModel.save()
                        onSave(newLocation)
                        dismiss()
                    }
                }
                            
                // destructive doesn't change color to red ??
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Delete", role: .destructive) {
                        onDelete(viewModel.location)
                        dismiss()
                    }
                    .foregroundColor(.red)
                }
                
            }
            .task {
                await viewModel.fetchNearbyPlaces()
            }
        }
    }
    
    //@escaping - function won't be called immediately, it will be called later on
    init(location: Location, onSave: @escaping (Location) -> Void, onDelete: @escaping (Location) -> Void) {
        _viewModel = StateObject(wrappedValue: ViewModel(location: location))
        self.onSave = onSave
        self.onDelete = onDelete
    }
    
    
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: Location.example) { _ in } onDelete: { _ in }

    }
}
