//
//  MeView.swift
//  HotProspects
//
//  Created by Bartosz Rola on 26/07/2023.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct MeView: View {
    @State private var name = "Anonymous"
    @State private var emailAddress = "you@yoursite.com"
    @State private var qrCode = UIImage()
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                    .textContentType(.name)
                    .font(.title)
                
                TextField("Email address", text: $emailAddress)
                    .textContentType(.emailAddress)
                    .font(.title)
                    .textInputAutocapitalization(.never)
                
                HStack {
                    Spacer()
                    
                    Image(uiImage: qrCode)
                        .resizable()
                        .interpolation(.none)
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .contextMenu {
                            Button {
                                let imageSaver = ImageSaver()
                                imageSaver.writeToPhotoAlbum(image: qrCode)
                            } label: {
                                Label("Save to Photos", systemImage: "square.and.arrow.down")
                            }
                    }
                    
                    Spacer()
                }
            }
            .navigationTitle("Your code")
            .onAppear {
                updateCode()
                loadUserData()
            }
            .onChange(of: name) { _ in
                updateCode()
                saveName()
            }
            .onChange(of: emailAddress) { _ in
                updateCode()
                saveEmail()
            }
        }
    }
    
    func updateCode() {
        qrCode = generateQRCode(from: "\(name)\n\(emailAddress)")
    }
    
    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
    func saveName() {
        UserDefaults.standard.set(name, forKey: "name")
    }
    
    func saveEmail() {
        UserDefaults.standard.set(emailAddress, forKey: "emailAddress")
    }
    
    func loadUserData() {
        name = UserDefaults.standard.string(forKey: "name") ?? "Anonymous"
        emailAddress = UserDefaults.standard.string(forKey: "emailAddress") ?? "you@yoursite.com"
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}

