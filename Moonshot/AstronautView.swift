//
//  AstronautView.swift
//  Moonshot
//
//  Created by Zaid Raza on 04/10/2020.
//  Copyright © 2020 Zaid Raza. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
    
    let astronaut: Astronaut
    let missions: [Mission]
    
    init(astronaut: Astronaut, missions: [Mission]) {
        self.astronaut = astronaut
        var matches = [Mission]()
        for mission in missions{
            for member in mission.crew{
                if member.name == astronaut.id{
                    matches.append(mission)
                }
            }
        }
        self.missions = matches
    }
    
    var body: some View {
        
        GeometryReader{geometry in
            ScrollView(.vertical){
                VStack{
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    
                    ForEach(self.missions){ mission in
                        
                        HStack() {
                            Image(mission.image)
                                .resizable()
                                .frame(width: 83, height: 60)
                                .clipShape(Capsule())
                                .overlay(Capsule().stroke(Color.primary, lineWidth: 1))
                            
                            VStack(alignment: .leading){
                                Text(mission.displayName)
                                    .font(.headline)
                                Text(mission.formattedLaunchDate)
                            }
                            Spacer()
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
}
