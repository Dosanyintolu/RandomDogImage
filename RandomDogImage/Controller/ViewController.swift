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
    var breeds: [String] = []
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        dogImageButton.layer.cornerRadius = 8
        clearButton.layer.cornerRadius = 8
        pickerView.dataSource = self
        pickerView.delegate = self
        
        requestBreedList(completionHandler: handleBreedResponse(error:breeds:))
    }
    
    
    @IBAction func fetchDogImage(_ sender: Any) {
        DispatchQueue.main.async {
            requestRandomImage(breed: self.breeds[self.pickerView.selectedRow(inComponent: 0)], completionHandler: self.handleRandomImageResponse(error:imageData:))
    }
}
    
    func handleImageFileResponse(image: UIImage?, error: Error?) {
        DispatchQueue.main.async {
            self.dogImageView.image = image
        }
    }
    
    func handleRandomImageResponse(error: Error?, imageData: DogImage?) {
        guard let imageURL = URL(string: imageData?.message.first ?? "") else {
            return
        }
        requestImageFile(url: imageURL, completionHandler: self.handleImageFileResponse(image:error:))
    }
    
    func handleBreedResponse(error: Error?, breeds: [String]) {
        self.breeds = breeds
        
        DispatchQueue.main.async {
            self.pickerView.reloadAllComponents()
        }
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



