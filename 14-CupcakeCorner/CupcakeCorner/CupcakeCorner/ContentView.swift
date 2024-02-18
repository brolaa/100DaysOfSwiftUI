//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Bartosz Rola on 25/02/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var order = Order()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.orderDetails.type) {
                        ForEach(OrderDetails.types.indices) {
                            Text(OrderDetails.types[$0])
                        }
                    }

                    Stepper("Number of cakes: \(order.orderDetails.quantity)", value: $order.orderDetails.quantity, in: 3...20)
                        .accessibilityElement()
                        .accessibilityLabel("Number of cakes")
                        .accessibilityValue(String(order.orderDetails.quantity))
                        .accessibilityAdjustableAction { direction in
                            switch direction {
                            case .increment:
                                if (order.orderDetails.quantity < 20) {
                                    order.orderDetails.quantity += 1
                                }
                            case .decrement:
                                if (order.orderDetails.quantity > 3) {
                                    order.orderDetails.quantity -= 1
                                }
                            default:
                                return
                            }
                        }
                }
                
                Section {
                    Toggle("Any special requests?", isOn: $order.orderDetails.specialRequestEnabled.animation())

                    if order.orderDetails.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.orderDetails.extraFrosting)

                        Toggle("Add extra sprinkles", isOn: $order.orderDetails.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink {
                        AddressView(order: order)
                    } label: {
                        Text("Delivery details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
