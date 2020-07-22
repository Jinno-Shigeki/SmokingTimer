//
//  BearViewController.swift
//  SmokingTimer
//
//  Created by 神野成紀 on 2020/07/22.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import UIKit

class BearViewController: UIViewController {
    
    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var setImageButton: UIButton!
    let pickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.object(forKey: "image") != nil {
            let image = UserDefaults.standard.data(forKey: "image")
            selectedImageView.image = UIImage(data: image!)
            setImageButton.setTitle(StaticData.buttonTitle, for: .normal)
        }
    }
    @IBAction func setImage(_ sender: UIButton) {
        present(pickerController, animated: true, completion: nil)
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
    }
}
//MARK: - UIImagePickerControllerDelegate
extension BearViewController: UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            print("error")
            return
        }
        let imageData = selectedImage.pngData()
        selectedImageView.image = selectedImage
        setImageButton.setTitle(StaticData.buttonTitle, for: .normal)
        if UserDefaults.standard.data(forKey: "image") != nil {
            UserDefaults.standard.removeObject(forKey: "image")
        }
        dismiss(animated: true) {
            UserDefaults.standard.set(imageData, forKey: "image")
        }
    }
}
//MARK: - UINavigationControllerDelegate
extension BearViewController: UINavigationControllerDelegate {
    
}


