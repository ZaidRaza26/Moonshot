//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Zaid Raza on 02/10/2020.
//  Copyright © 2020 Zaid Raza. All rights reserved.
//

import Foundation
extension Bundle{
    
    func decode<T: Codable>(_ file: String) -> [T] {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) from bundle")
        }
        
        guard let data = try? Data(contentsOf: url) else{
            fatalError("failed to load \(file) from bundle")
        }
        
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let loaded = try? decoder.decode([T].self, from: data) else{
            fatalError("failed to read data from \(file)")
        }
        return loaded
    }
}
