//
//  Mission.swift
//  Moonshot
//
//  Created by Zaid Raza on 02/10/2020.
//  Copyright © 2020 Zaid Raza. All rights reserved.
//

import Foundation

struct Mission: Codable,Identifiable {
    
    struct crewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [crewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String{
        if let launchDate = launchDate{
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        }
        else{
            return "N/A"
        }
    }
}
