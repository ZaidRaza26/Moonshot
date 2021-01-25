//
//  MissionView.swift
//  Moonshot
//
//  Created by Zaid Raza on 03/10/2020.
//  Copyright © 2020 Zaid Raza. All rights reserved.
//

import SwiftUI

struct MissionView: View {
    
    var geoHeight = 0.0
    
    let mission: Mission

    let astronauts: [CrewMember]
    let missions : [Mission]

    
    init(mission: Mission, astronauts: [Astronaut],missions: [Mission]){
        self.mission = mission
        var matches = [CrewMember]()
        self.missions = missions
        
        for member in mission.crew{
            if let match = astronauts.first(where: {$0.id == member.name}){
                matches.append(CrewMember(role: member.role, astronaut: match))
            }
            else{
                fatalError("mission crew \(member)")
            }
        }
        self.astronauts = matches
    }
    
    var body: some View {
        GeometryReader{ geometry in
            ScrollView(.vertical){
                VStack{
                    GeometryReader{ geo in
                        Image(self.mission.image)
                            .resizable()
                            .padding(.top)
                            .coordinateSpace(name: "Custom")
                            .frame(maxHeight: geo.frame(in: .named("Custom")).maxY / 0.8)
                    }
                    .scaledToFit()
                    .frame(width: geometry.size.width * 0.8, height: 240)
                    
                    Text(self.mission.formattedLaunchDate)
                    
                    Text(self.mission.description)
                        .padding()
                    
                    ForEach(self.astronauts, id: \.role) { crewMember in
                        NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut,missions: self.missions)){
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 83, height: 60)
                                    .clipShape(Capsule())
                                    .overlay(Capsule().stroke(Color.primary, lineWidth: 1))
                                
                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .font(.headline)
                                    Text(crewMember.role)
                                        .foregroundColor(crewMember.role == "Commander" ? .blue : .secondary)
                                }
                                Spacer()
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.horizontal)
                    }
                    Spacer(minLength: 25)
                }
            }
            .navigationBarTitle(Text(self.mission.displayName), displayMode: .inline)
        }
    }
}

struct CrewMember {
    let role: String
    let astronaut: Astronaut
}
