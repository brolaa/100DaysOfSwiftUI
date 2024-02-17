//
//  MissionsScrollView.swift
//  Moonshot
//
//  Created by Bartosz Rola on 19/02/2023.
//

import SwiftUI

struct MissionsScrollView: View {
    struct AstronautMissions {
        let mission: [Mission]
        let role: String
    }
    
    let astronaut: Astronaut
    let astronautMissions: [AstronautMissions]
    //let missions: [Mission]
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    init(astronaut: Astronaut, missions: [Mission]) {
        self.astronaut = astronaut
        
        self.astronautMissions = for mission in missions {
            for member in mission.crew {
                if member.name == astronaut.name {
                    return AstronautMissions(mission: missions, role: member.role)
                    }
                }
        }
            
        }
    }
}

struct MissionsScrollView_Previews: PreviewProvider {
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        MissionsScrollView(astronaut: astronauts["aldrin"]!, missions: missions)
            .preferredColorScheme(.dark)
    }
}
