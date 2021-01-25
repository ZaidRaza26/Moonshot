//
//  ContentView.swift
//  Moonshot
//
//  Created by Zaid Raza on 01/10/2020.
//  Copyright © 2020 Zaid Raza. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var displayName = false
    
    var body: some View {
        
        NavigationView{
            List(missions){ mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts,missions: self.missions)){
                    Image(mission.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 44, height: 44)
                    
                    VStack(alignment: .leading){
                        Text(mission.displayName)
                            .font(.headline)
                        Text(self.displayName ? mission.formattedLaunchDate : self.getAstronauts(mission: mission))
                    }
                    .accessibilityElement(children: .ignore)
                    .accessibility(label: Text(self.displayName ? "Mission name is \(mission.displayName) and launch date is \(mission.formattedLaunchDate)" : self.getAstronautsForVoiceOver(mission: mission)))
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(leading: Button("Toggle"){
                self.displayName.toggle()
            })
        }
    }
    
    func getAstronauts(mission: Mission) -> String {
        var astronautArray = [String]()
        for astronaut in 0..<astronauts.count{
            for item in 0..<mission.crew.count{
                if astronauts[astronaut].id == mission.crew[item].name{
                    astronautArray.append(astronauts[astronaut].name)
                }
            }
        }
        let astronautsSet = Set(astronautArray)
        return astronautsSet.joined(separator: "\n")
    }
    
    func getAstronautsForVoiceOver(mission: Mission) -> String {
        var astronautArray = [String]()
        for astronaut in 0..<astronauts.count{
            for item in 0..<mission.crew.count{
                if astronauts[astronaut].id == mission.crew[item].name{
                    astronautArray.append(astronauts[astronaut].name)
                }
            }
        }
        
        let astronautsSet = Set(astronautArray)
        return "Mission name is \(mission.displayName)and  The Astronauts for this mission are \(astronautsSet.joined(separator: "\n"))"
    }
}


struct User: Codable {
    var name: String
    var address: Address
}

struct Address: Codable {
    var street: String
    var city: String
}


struct CustomText: View {
    let text: String
    
    var body: some View{
        Text(text)
    }
    
    init(_ text: String) {
        print("Creating a new CustomText")
        self.text = text
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
