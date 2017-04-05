//
//  Pokemon.swift
//  demo3
//
//  Created by Shannon Phu on 4/2/17.
//  Copyright © 2017 Shannon Phu. All rights reserved.
//

import UIKit

class Pokemon: NSObject {
    var name: String
    var imageURL: URL
    var type: String
    var weight: Double
    
    init(name: String, imageURL: String, type: String, weight: String) {
        self.name = name
        self.imageURL = URL(string: imageURL)!
        self.type = type
        let parsedWeight = weight.replacingOccurrences(of: " kg", with: "")
        let convertedWeight: Double = Double(parsedWeight)!
        self.weight = convertedWeight
    }
}
