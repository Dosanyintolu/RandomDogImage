//
//  DogAPI.swift
//  RandomDogImage
//
//  Created by Doyinsola Osanyintolu on 4/20/20.
//  Copyright © 2020 DoyinOsanyintolu. All rights reserved.
//

import Foundation
import UIKit


enum DogEndPoint: String {
    
    case http = "https://dog.ceo/api/breeds/image/random"
    
    var url: URL{
        return URL(string: self.rawValue)!
    }
}

func requestImageFile(url: URL, completionHandler: @escaping(UIImage?, Error?) -> Void) {
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let data = data else {
            completionHandler(nil, error)
            return
        }
        let downloadedDogImage = UIImage(data: data)
            completionHandler(downloadedDogImage, nil)
    }
        task.resume()
}

func requestRandomImage(url:URL, completionHandler: @escaping (Error?, DogImage?) -> Void) {
           
           let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
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

