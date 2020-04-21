//
//  ViewController.swift
//  RandomDogImage
//
//  Created by Doyinsola Osanyintolu on 4/20/20.
//  Copyright © 2020 DoyinOsanyintolu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dogImageView: UIImageView!
    @IBOutlet weak var dogImageButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        dogImageButton.layer.cornerRadius = 8
        clearButton.layer.cornerRadius = 8
    }
    
    
    @IBAction func fetchDogImage(_ sender: Any) {
        

        guard let url = URL(string: DogEndPoint.http.rawValue) else {
            print("Bad URL")
            return
        }
        
        requestRandomImage(url: url, completionHandler:handleRandomImageResponse(error:imageData:))
            
    }
    
    func handleImageFileResponse(image: UIImage?, error: Error?) {
        DispatchQueue.main.async {
            self.dogImageView.image = image
        }
    }
    
    func handleRandomImageResponse(error: Error?, imageData: DogImage?) {
        guard let dogURL = URL(string: imageData?.message ?? "") else {
                       return
                   }
                   requestImageFile(url: dogURL, completionHandler: self.handleImageFileResponse(image:error:))
               }

    @IBAction func clearImageFunction(_ sender: Any) {
        
        if dogImageView.image == nil {
            let messaege = "Nothing to clear"
            let title = "No Image Found"
            let alert = UIAlertController(title: title, message: messaege, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true)
        } else {
            dogImageView.image = nil
        }
    }
}


