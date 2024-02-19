//
//  ContentView.swift
//  Instafilter
//
//  Created by Bartosz Rola on 13/04/2023.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 0.5
    @State private var filterScale = 0.5
    
    @State private var filterSharpness = 0.5
    @State private var filterSaturation = 0.5
    @State private var filterBrightness = 0.5
    @State private var filterContrast = 0.5
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    @State private var showingFilterSheet = false
    
    @State private var showingIntensitySlider = true
    @State private var showingRadiusSlider = false
    @State private var showingScaleSlider = false
    
    @State private var showingSharpnessSlider = false
    @State private var showingSaturationSlider = false
    @State private var showingBrightnessSlider = false
    @State private var showingContrastSlider = false
    
    let filterOptions: [(label: String, filter: CIFilter)] = [
        ("Crystallize", CIFilter.crystallize()), //inputRadius, inputCenter
        ("Edges", CIFilter.edges()), //inputIntensity
        ("Gaussian Blur", CIFilter.gaussianBlur()), //inputRadius
        ("Pixellate", CIFilter.pixellate()), //inputScale, inputCenter
        ("Sepia Tone", CIFilter.sepiaTone()), //inputIntensity
        ("Unsharp Mask", CIFilter.unsharpMask()), //inputRadius, inputIntensity
        ("Vignette", CIFilter.vignette()), // inputIntensity, inputRadius
        ("Pointillize", CIFilter.pointillize()), //inputRadius
        ("Sharpen Luminance", CIFilter.sharpenLuminance()), //inputRadius, inputSharpness
        ("Color Controls", CIFilter.colorControls())
            //inputBrightness, inputContrast, inputSaturation
    ]
    
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(.secondary)
                    
                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                    
                    image?
                        .resizable()
                        .scaledToFit()
                }
                .onTapGesture {
                    showingImagePicker = true
                }
                
                if (showingIntensitySlider) {
                    HStack {
                        Text("Intensity")
                        Slider(value: $filterIntensity)
                            .onChange(of: filterIntensity) { _ in
                                applyProcessing()
                            }
                    }
                    .padding(.vertical)
                }
                
                if (showingRadiusSlider) {
                    HStack {
                        Text("Radius")
                        Slider(value: $filterRadius)
                            .onChange(of: filterRadius) { _ in
                                applyProcessing()
                            }
                    }
                    .padding(.vertical)
                }
                
                if (showingScaleSlider) {
                    HStack {
                        Text("Scale")
                        Slider(value: $filterScale)
                            .onChange(of: filterScale) { _ in
                                applyProcessing()
                            }
                    }
                    .padding(.vertical)
                }
                
                if (showingSharpnessSlider) {
                    HStack {
                        Text("Sharpness")
                        Slider(value: $filterSharpness)
                            .onChange(of: filterSharpness) { _ in
                                applyProcessing()
                            }
                    }
                    .padding(.vertical)
                }
                
                if (showingBrightnessSlider) {
                    HStack {
                        Text("Brightness")
                        Slider(value: $filterBrightness)
                            .onChange(of: filterBrightness) { _ in
                                applyProcessing()
                            }
                    }
                    .padding(.vertical)
                }
                
                if (showingContrastSlider) {
                    HStack {
                        Text("Contrast")
                        Slider(value: $filterContrast)
                            .onChange(of: filterContrast) { _ in
                                applyProcessing()
                            }
                    }
                    .padding(.vertical)
                }
                
                if (showingSaturationSlider) {
                    HStack {
                        Text("Saturation")
                        Slider(value: $filterSaturation)
                            .onChange(of: filterSaturation) { _ in
                                applyProcessing()
                            }
                    }
                    .padding(.vertical)
                }
                
                HStack {
                    Button("Change Filter") {
                        showingFilterSheet = true
                    }
                    
                    Spacer()
                    
                    Button("Save", action: save)
                        .disabled(inputImage==nil ? true : false)
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .onChange(of: inputImage) { _ in loadImage() }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .confirmationDialog("Select a filter", isPresented: $showingFilterSheet) {
                ForEach(filterOptions.indices) { option in
                    Button(filterOptions[option].label) {
                        setFilter(filterOptions[option].filter)
                    }
                }
                Button("Cancel", role: .cancel) { }
            }
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func save() {
        guard let processedImage = processedImage else { return }
        
        let imageSaver = ImageSaver()
        
        imageSaver.successHandler = {
            print("Success!")
        }
        
        imageSaver.errorHandler = {
            print("Oops! \($0.localizedDescription)")
        }
        
        imageSaver.writeToPhotoAlbum(image: processedImage)
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterRadius * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterScale * 10, forKey: kCIInputScaleKey)
        }
        if inputKeys.contains(kCIInputSharpnessKey) {
            currentFilter.setValue(filterSharpness * 10, forKey: kCIInputSharpnessKey)
        }
        if inputKeys.contains(kCIInputContrastKey) {
            currentFilter.setValue(filterContrast * 2, forKey: kCIInputContrastKey)
        }
        if inputKeys.contains(kCIInputBrightnessKey) {
            currentFilter.setValue(filterBrightness * 2 - 1, forKey: kCIInputBrightnessKey)
        }
        if inputKeys.contains(kCIInputSaturationKey) {
            currentFilter.setValue(filterSaturation * 2, forKey: kCIInputSaturationKey)
        }
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        
        loadSliders()
        
        loadImage()
    }
    
    func loadSliders() {
        let inputKeys = currentFilter.inputKeys
        
        showingIntensitySlider = false
        showingRadiusSlider = false
        showingScaleSlider = false
        showingSharpnessSlider = false
        showingContrastSlider = false
        showingBrightnessSlider = false
        showingSaturationSlider = false
        
        filterIntensity = 0.5
        filterRadius = 0.5
        filterScale = 0.5
        filterSharpness = 0.5
        filterSaturation = 0.5
        filterContrast = 0.5
        filterBrightness = 0.5
        
        
        if inputKeys.contains(kCIInputIntensityKey) {
            showingIntensitySlider = true
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            showingRadiusSlider = true
        }
        if inputKeys.contains(kCIInputScaleKey) {
            showingScaleSlider = true
        }
        if inputKeys.contains(kCIInputSharpnessKey) {
            showingSharpnessSlider = true
        }
        if inputKeys.contains(kCIInputSaturationKey) {
            showingSaturationSlider = true
        }
        if inputKeys.contains(kCIInputBrightnessKey) {
            showingBrightnessSlider = true
        }
        if inputKeys.contains(kCIInputContrastKey) {
            showingContrastSlider = true
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


/*
 .confirmationDialog("Select a filter", isPresented: $showingFilterSheet) {
     Button("Crystallize") { setFilter(CIFilter.crystallize()) } //inputRadius, inputCenter
     Button("Edges") { setFilter(CIFilter.edges()) } //inputIntensity
     Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) } //inputRadius
     Button("Pixellate") { setFilter(CIFilter.pixellate()) } //inputScale, inputCenter
     Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) } //inputIntensity
     Button("Unsharp Mask") {  setFilter(CIFilter.unsharpMask()) } //inputRadius, inputIntensity
     Button("Vignette") { setFilter(CIFilter.vignette()) } // inputIntensity, inputRadius
     Button("Pointillize") { setFilter(CIFilter.pointillize()) } //inputRadius
     Button("Sharpen Luminance") { setFilter(CIFilter.sharpenLuminance()) } //inputRadius, inputSharpness
     Button("Color Controls") { setFilter(CIFilter.colorControls()) }
         //inputBrightness, inputContrast, inputSaturation
     Button("Cancel", role: .cancel) { }
 }
 */
/*
let confirmationDialogOptions: [(label: String, filter: CIFilter)] = [
    ("Crystallize", CIFilter.crystallize()), //inputRadius, inputCenter
    ("Edges", CIFilter.edges()), //inputIntensity
    ("Gaussian Blur": CIFilter.gaussianBlur()), //inputRadius
    ("Pixellate": CIFilter.pixellate()), //inputScale, inputCenter
    ("Sepia Tone": CIFilter.sepiaTone()), //inputIntensity
    ("Unsharp Mask": CIFilter.unsharpMask()), //inputRadius, inputIntensity
    ("Vignette": CIFilter.vignette()), // inputIntensity, inputRadius
    ("Pointillize": CIFilter.pointillize()), //inputRadius
    ("Sharpen Luminance": CIFilter.sharpenLuminance()), //inputRadius, inputSharpness
    ("Color Controls": CIFilter.colorControls())
        //inputBrightness, inputContrast, inputSaturation
]
*/

/*
 let confirmationDialogOptions: [String: CIFilter] = [
     "Crystallize": CIFilter.crystallize(), //inputRadius, inputCenter
     "Edges": CIFilter.edges(), //inputIntensity
     "Gaussian Blur": CIFilter.gaussianBlur(), //inputRadius
     "Pixellate": CIFilter.pixellate(), //inputScale, inputCenter
     "Sepia Tone": CIFilter.sepiaTone(), //inputIntensity
     "Unsharp Mask": CIFilter.unsharpMask(), //inputRadius, inputIntensity
     "Vignette": CIFilter.vignette(), // inputIntensity, inputRadius
     "Pointillize": CIFilter.pointillize(), //inputRadius
     "Sharpen Luminance": CIFilter.sharpenLuminance(), //inputRadius, inputSharpness
     "Color Controls": CIFilter.colorControls()
         //inputBrightness, inputContrast, inputSaturation
 ]
 */
