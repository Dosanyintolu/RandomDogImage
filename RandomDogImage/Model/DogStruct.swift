//
//  DogAPI.swift
//  RandomDogImage
//
//  Created by Doyinsola Osanyintolu on 4/20/20.
//  Copyright © 2020 DoyinOsanyintolu. All rights reserved.
//

import Foundation



struct DogImage: Codable {
    
    let status: String
    let message: String
}

struct BreedList: Codable {
    let message: [String: [String]]
    let status: String
}
