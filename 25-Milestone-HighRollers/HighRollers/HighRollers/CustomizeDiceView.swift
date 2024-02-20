//
//  CustomizeDiceView.swift
//  HighRollers
//
//  Created by Bartosz Rola on 21/08/2023.
//

import SwiftUI

struct CustomizeDiceView: View {
    @Binding var sides: Int
    @Binding var amount: Int
    
    @Environment(\.dismiss) var dismiss
    
    let onClose: () -> Void
    
    let sidesList = [4, 6, 8, 10, 12, 20, 100]
    
    var body: some View {
        NavigationView {
            List {
                Stepper("Dice amount: \(amount)", value: $amount, in: 1...20)

                Picker("Number of sides", selection: $sides) {
                    ForEach(sidesList, id: \.self) {
                        Text("\($0)")
                    }
                }
            }
            .navigationTitle("Customize")
            .toolbar {
                Button("Done", action: done)
            }
        }
    }
    
    func done() {
        onClose()
        dismiss()
    }
}

struct CustomizeDiceView_Previews: PreviewProvider {
    static var previews: some View {
        CustomizeDiceView(sides: .constant(6), amount: .constant(2)) {  }
    }
}
