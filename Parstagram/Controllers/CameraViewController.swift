//
//  CameraViewController.swift
//  Parstagram
//
//  Created by Marty Nodado on 3/1/21.
//

import UIKit
import AlamofireImage
import Parse

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var captureImageView: UIImageView!
    @IBOutlet weak var captionTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSubmitButton(_ sender: Any) {
//        let pet = PFObject(className: "Pets") // like its own dictionary,
//
//        pet["name"] = "Brian"
//        pet["weight"] = 50
//        pet["owner"] = PFUser.current()!
//
//        pet.saveInBackground { (success, error) in
//            if success {
//                print("Saved!")
//            } else {
//                print("Error!")
//            }
//        }
        
        let post = PFObject(className: "Posts")
        
        post["caption"] = captionTextField.text!
        post["author"] = PFUser.current()!
        
        let imageData = captureImageView.image!.pngData()
        let file = PFFileObject(data: imageData!)
        
        post["image"] = file
        post.saveInBackground { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
                print("posted into Parse!")
            } else {
                print("error saving post!")
            }
        }
    }
    
    @IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        
        picker.delegate = self // when pic is taken, calls back
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil) // will show photo album
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageScaled(to: size)
        
        captureImageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
