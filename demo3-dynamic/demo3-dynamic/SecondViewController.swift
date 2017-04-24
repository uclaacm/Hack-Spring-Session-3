//
//  SecondViewController.swift
//  demo3-dynamic
//
//  Created by Jahan Cherian on 4/23/17.
//  Copyright © 2017 Jahan Cherian. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemTitle: UITextField!
    @IBOutlet weak var itemSubtitle: UITextField!
    
    
    // This will bring up the image picker from your camera roll
    // To allow for this to happen, put NSPhotoLibraryUsageDescription in the Info.plist
    @IBAction func importImage(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        
        self.present(image, animated: true){
            // Whatever you want to do when the image picker controller happens
        }
    }
    
    // Make sure the image picked is a valid image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            self.itemImage.image = image
        } else {
            // Some sort of Error message
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
