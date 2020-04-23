//
//  DogAPI.swift
//  RandomDogImage
//
//  Created by Doyinsola Osanyintolu on 4/20/20.
//  Copyright © 2020 DoyinOsanyintolu. All rights reserved.
//

import Foundation
import UIKit

enum DogEndPoint {
    
    case http
    case randomImageForBreed(String)
    case listAllBreeds

    var url: URL{
        return URL(string: stringValue)!
    }
    
    var stringValue: String {
        switch self {
        case .http:
            return "https://dog.ceo/api/breeds/image/random"
        case .randomImageForBreed(let breed):
            return "https://dog.ceo/api/breed/\(breed)/images"
        case .listAllBreeds:
            return "https://dog.ceo/api/breeds/list/all"
        }
    }
}

func requestImageFile(breed: String, completionHandler: @escaping(UIImage?, Error?) -> Void) {
    
    let randomEndPoint = DogEndPoint.randomImageForBreed(breed).url
    let task = URLSession.shared.dataTask(with: randomEndPoint) { (data, response, error) in
        guard let data = data else {
            completionHandler(nil, error)
            return
        }
        let downloadedDogImage = UIImage(data: data)
            completionHandler(downloadedDogImage, nil)
        }
        task.resume()
}
func requestRandomImage(completionHandler: @escaping (Error?, DogImage?) -> Void) {
           
        let randomEndPoint = DogEndPoint.http.url
           let task = URLSession.shared.dataTask(with: randomEndPoint) { (data, response, error) in
               guard let data = data else {
                   completionHandler(error, nil)
                   return
               }
            let decoder = JSONDecoder()
            let imageData = try! decoder.decode(DogImage.self, from: data)
            completionHandler(nil, imageData)
    }
    task.resume()
}

func requestBreedList(completionHandler: @escaping (Error?, [String]) -> Void) {
    let randomBreed = DogEndPoint.listAllBreeds.url
    let task = URLSession.shared.dataTask(with: randomBreed) {(data, response, error) in
        guard let data = data else {
            completionHandler(error,[])
        return
        }
        let decoder = JSONDecoder()
        
        do {
            let dogData = try decoder.decode(BreedList.self, from: data)
            let breeds = dogData.message.keys.map({$0})
            completionHandler(nil, breeds)
        } catch {
            print(error)
        }
    }
    task.resume()
}

