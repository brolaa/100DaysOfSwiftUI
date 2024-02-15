//
//  ContentView.swift
//  UnitConverter
//
//  Created by Bartosz Rola on 19/09/2022.
//

import SwiftUI

struct ContentView: View {
    @FocusState private var inputIsFocused: Bool
    
    @State private var inputUnit = 0
    @State private var outputUnit = 0
    
    @State private var inputValue: Double = 0
   
    @State private var currentUnit = 0
    
    private var outputValue: Double {
        switch currentUnit {
        case 0:
            return temperatureConvertion(inputUnit: self.inputUnit, outputUnit: self.outputUnit, value: inputValue)
        case 1:
            return lengthConversion(inputUnit: self.inputUnit, outputUnit: self.outputUnit, value: inputValue)
        case 2:
            return timeConversion(inputUnit: self.inputUnit, outputUnit: self.outputUnit, value: inputValue)
        default:
            return volumeConversion(inputUnit: self.inputUnit, outputUnit: self.outputUnit, value: inputValue)
            
        }

    }
    
    let unit = ["Temperature", "Length", "Time", "Volume"]
    
    let units = [
        ["Celsius", "Fahrenheit", "Kelvin", "Rankine"],
        ["Meter", "Kilometer", "Yard", "Feet", "Mile"],
        ["Seconds", "Minutes", "Hours", "Days", "Years"],
        ["Mililitre", "Litre", "Cup", "Pint", "Gallon"]
    ]
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Choose unit", selection: $currentUnit) {
                        ForEach(0 ..< unit.count, id: \.self) {
                            Text(self.unit[$0])
                        }
                    }.onAppear {
                        inputUnit = 0
                        outputUnit = 0
                    }
                }
                
                Section {
                    TextField("Input value", value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                } header: {
                    Text("Enter input value")
                }
                
                Section {
                    Picker("Input unit", selection: $inputUnit) {
                        ForEach(0 ..< units[currentUnit].count, id: \.self) {
                            Text(self.units[currentUnit][$0])
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Choose input unit")
                }
                
                Section {
                    Picker("Output unit", selection: $outputUnit) {
                        ForEach(0 ..< units[currentUnit].count, id: \.self) {
                            Text(self.units[currentUnit][$0])
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Choose output unit")
                }
                
                Section {
                    Text(outputValue, format: .number)
                } header: {
                    Text("Output value")
                }
            }
            .navigationTitle("UnitConverter")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()

                    Button("Done") {
                        inputIsFocused = false
                    }
                }
            }
        }
    }
    
    func temperatureConvertion(inputUnit: Int, outputUnit: Int, value: Double) -> Double {
        // Converts input temperature to Celsius then to output temperature
        let tempValue: Double
        
        switch inputUnit {
        case 1: // Farenheit
            tempValue = (value - 32) / 1.8
        case 2: // Kelvin
            tempValue = value - 273.15
        case 3: // Rankine
            tempValue = (value - 491.67) / 1.8
        default:
            tempValue = value
        }
        
        switch outputUnit {
        case 1: // Farenheit
            return (tempValue * 1.8) + 32
        case 2: // Kelvin
            return tempValue + 273.15
        case 3: // Rankine
            return (tempValue + 273.15) * 1.8
        default:
            return tempValue
        }
    }
    
    func lengthConversion(inputUnit: Int, outputUnit: Int, value: Double) -> Double {
        // Converts input length to Meters then to output length
        let tempValue: Double
        
        switch inputUnit {
        case 1: // Kilometer
            tempValue = value * 1000
        case 2: // Yard
            tempValue = value / 1.0936
        case 3: // Feet
            tempValue = value / 3.2808
        
        case 4: // Mile
            tempValue = value / 0.00062137
        default:
            tempValue = value
        }
        
        switch outputUnit {
        case 1: // Kilometer
            return tempValue / 1000
        case 2: // Yard
            return tempValue * 1.0936
        case 3: // Feet
            return tempValue * 3.2808
        
        case 4: // Mile
            return tempValue * 0.00062137
        default:
            return tempValue
        }
    }
    
    func timeConversion(inputUnit: Int, outputUnit: Int, value: Double) -> Double {
        // Converts input time to Seconds then to output time unit
        let tempValue: Double
        
        switch inputUnit {
        case 1: // Minutes
            tempValue = value * 60
        case 2: // Hours
            tempValue = value * 3600
        case 3: // Days
            tempValue = value * 86400
        case 4: // Years
            tempValue = value * 31_536_000
        default:
            tempValue = value
        }
        
        switch outputUnit {
        case 1: // Minutes
            return tempValue / 60
        case 2: // Days
            return tempValue / 3600
        case 3: // Hours
            return tempValue / 86400
        case 4: // Years
            return tempValue / 31_536_000
        default:
            return tempValue
        }
    }
    
    func volumeConversion(inputUnit: Int, outputUnit: Int, value: Double) -> Double {
        // Converts input volume to Mililiters then to output volume
        let tempValue: Double
        
        switch inputUnit {
        case 1: // Litre
            tempValue = value / 0.001
        case 2: // Cup
            tempValue = value / 0.0042268
        case 3: // Pint
            tempValue = value / 0.0021134
        case 4: // Gallon
            tempValue = value / 0.00026417
        default:
            tempValue = value
        }
        
        switch outputUnit {
        case 1: // Litre
            return tempValue * 0.001
        case 2: // Cup
            return tempValue * 0.0042268
        case 3: // Pint
            return tempValue * 0.0021134
        case 4: // Gallon
            return tempValue * 0.00026417
        default:
            return tempValue
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



// Temperatures
// input unit -> celsius -> output unit

// Celsius (°C) = (Fahrenheit - 32) / 1.8
// Celsius (°C) = Kelvin - 273.15
// Celsius (°C) = (Rankine - 491.67) / 1.8

// Fahrenheit (°F) = (Celsius x 1.8) + 32
// Kelvin (K) = Celsius + 273.15
// Rankine (°R) = (Celsius + 273.15) x 1.8

// Length
// input unit -> meters -> output unit

// Meter = Kilometer * 1000
// Meter = Feet / 3.2808
// Meter = Yard / 1.0936
// Meter = Mile / 0.00062137

// Kliometer = Meter / 1000
// Feet = Meter * 3.2808
// Yard = Meter * 1.0936
// Mile = Meter * 0.00062137

// Time
// input unit -> seconds -> output unit

// Seconds = Minutes * 60
// Seconds = Hours * 3600
// Seconds = Days * 86400

// Minutes = Seconds / 60
// Hours = Seconds / 3600
// Days = Seconds / 86400

// Volume
// input unit -> mililiters -> output unit

// Mililiters = Liters / 0.001
// Mililiters = Cups / 0.0042268
// Mililiters = Pints / 0.0021134
// Mililiters = Gallon / 0.00026417

// Liters = Mililiters * 0.001
// Cups = Mililiters * 0.0042268
// Pints = Mililiters * 0.0021134
// Gallon = Mililiters * 0.00026417
