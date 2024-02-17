//
//  MissionView.swift
//  Moonshot
//
//  Created by Bartosz Rola on 18/02/2023.
//

import SwiftUI

struct MissionView: View {
    let mission: Mission
    let astronauts: [String: Astronaut]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.6)
                        .padding(.top)
                        .accessibilityLabel("\(mission.displayName)'s patch")
                    
                    VStack(alignment: .leading) {
                        RectangleDivider()
                        
                        Text(mission.formattedFullLaunchDate)
                            .font(.headline)
                            .foregroundColor(.white.opacity(0.5))
                        
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)

                        Text(mission.description)
                        
                        RectangleDivider()
                        
                        Text("Crew")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                    }
                    .padding(.horizontal)
                    
                    //showIndicators hides scroll bar
                    CrewScrollView(mission: mission, astronauts: astronauts)
                }
                .padding(.bottom)
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")


    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}

/*


 import SwiftUI

 struct MissionView: View {
     struct CrewMember {
         let role: String
         let astronaut: Astronaut
     }
     
     let mission: Mission
     let crew: [CrewMember]
     let astronauts: [String: Astronaut]
     
     var body: some View {
         GeometryReader { geometry in
             ScrollView {
                 VStack {
                     Image(mission.image)
                         .resizable()
                         .scaledToFit()
                         .frame(maxWidth: geometry.size.width * 0.6)
                         .padding(.top)
                     
                     VStack(alignment: .leading) {
                         RectangleDivider()
                         
                         Text(mission.formattedFullLaunchDate)
                             .font(.headline)
                             .foregroundColor(.white.opacity(0.5))
                         
                         Text("Mission Highlights")
                             .font(.title.bold())
                             .padding(.bottom, 5)

                         Text(mission.description)
                         
                         RectangleDivider()
                         
                         Text("Crew")
                             .font(.title.bold())
                             .padding(.bottom, 5)
                     }
                     .padding(.horizontal)
                     
                     //showIndicators hides scroll bar
                     CrewScrollView(mission: mission, astronauts: astronauts)
                 }
                 .padding(.bottom)
             }
         }
         .navigationTitle(mission.displayName)
         .navigationBarTitleDisplayMode(.inline)
         .background(.darkBackground)
     }
     
     init(mission: Mission, astronauts: [String: Astronaut]) {
         self.mission = mission
         
         self.crew = mission.crew.map { member in
             if let astronaut = astronauts[member.name] {
                 return CrewMember(role: member.role, astronaut: astronaut)
             } else {
                 fatalError("Missing \(member.name)")
             }
         }
     }
 }

 struct MissionView_Previews: PreviewProvider {
     static let missions: [Mission] = Bundle.main.decode("missions.json")
     static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")


     static var previews: some View {
         MissionView(mission: missions[0], astronauts: astronauts)
             .preferredColorScheme(.dark)
     }
 }

 */
