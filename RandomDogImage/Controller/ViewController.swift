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
    @IBOutlet weak var pickerView: UIPickerView!
    let breeds: [String] = ["pitbull", "poodle"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        dogImageButton.layer.cornerRadius = 8
        clearButton.layer.cornerRadius = 8
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    
    @IBAction func fetchDogImage(_ sender: Any) {
        
        requestRandomImage(completionHandler:handleRandomImageResponse(error:imageData:))
    }
    
    func handleImageFileResponse(image: UIImage?, error: Error?) {
        DispatchQueue.main.async {
            self.dogImageView.image = image
        }
    }
    
    func handleRandomImageResponse(error: Error?, imageData: DogImage?) {
        
        requestImageFile(breed:breeds[1],completionHandler: self.handleImageFileResponse(image:error:))
               }
    
    func handleBreedResponse(error: Error?, dogData: BreedList?) {
        

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

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return breeds.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return breeds[row]
    }
}


