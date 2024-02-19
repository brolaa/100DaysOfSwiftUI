//
//  CircleView.swift
//  FaceReminder
//
//  Created by Bartosz Rola on 22/07/2023.
//

import SwiftUI

struct CircleView: View {
    let image: Image?
    
    var body: some View {
        if image != nil {
            image?
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .shadow(radius: 3)
        } else {
            ZStack {
                Circle()
                    .fill(.secondary)
                    
                Image(systemName: "person")
                    .foregroundColor(.white)
                    .font(.title)
            }
            .frame(width: 50, height: 50)
            .shadow(radius: 3)
        }
        
    }
}

struct CircleView_Previews: PreviewProvider {
    static var previews: some View {
        CircleView(image: Image("JohnnyTest"))
    }
}
