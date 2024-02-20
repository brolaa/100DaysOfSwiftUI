//
//  NumberListView.swift
//  HighRollers
//
//  Created by Bartosz Rola on 22/08/2023.
//

import SwiftUI

struct UniqueInt: Identifiable {
    let value: Int
    let id = UUID()
}

struct NumberListView: View {
    var nums = [UniqueInt]()
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(nums) { num in
                    ZStack {
                        Circle()
                            .foregroundColor(.white)
                            .frame(width: 40, height: 40)
                            .shadow(radius: 2)
                        
                        Text("\(num.value)")
                            .foregroundColor(.black)
                            .font(.headline)
                    }
                }
            }
            .padding(3)
        }
    }
    
    init(numbers: [Int]) {
        for num in numbers {
            let unique =  UniqueInt(value: num)
            nums.append(unique)
        }
    }
}

struct NumberListView_Previews: PreviewProvider {
    static var previews: some View {
        NumberListView(numbers: [100, 6, 3, 4])
    }
}
