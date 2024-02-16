//
//  ContentView.swift
//  BetterRest
//
//  Created by Bartosz Rola on 01/10/2022.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    //@State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var idealBedtime: String {
        return calculateBedtime()
    }
    
    var body: some View {
        NavigationView {
            Form {
               Section {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden()
               } header: {
                   Text("When do you want to wake up?")
                           .font(.subheadline)
               }
                
                Section {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                } header: {
                    Text("Desired amount of sleep")
                        .font(.subheadline)
                }
                
                Section {
                    VStack(alignment: .leading, spacing: 5) {
                        Picker("Daily coffee intake", selection: $coffeeAmount) {
                            ForEach(1..<21) {
                                $0 == 1 ? Text("1 cup") : Text("\($0) cups")
                            }
                        }
                    }
                }
                
                Section {
                    Text("Your ideal bed time is \(idealBedtime)")
                        .font(.headline)
                }
            }
            .navigationTitle("BetterRest")
            /*
            .toolbar {
                Button("Calculate", action: calculateBedtime)
            }
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
             */
        }
    }
    
    func calculateBedtime() -> String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)

            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            return sleepTime.formatted(date: .omitted, time: .shortened)
            /*
            alertTitle = "Your ideal bedtime is…"
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
             */
        } catch {
            return "Error!"
            /*
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
             */
        }
        
        //showingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
