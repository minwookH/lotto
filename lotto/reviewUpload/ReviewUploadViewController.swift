//
//  ReviewUploadViewController.swift
//  lotto
//
//  Created by teruten on 2018. 5. 15..
//  Copyright © 2018년 Dev. All rights reserved.
//

import UIKit
import MobileCoreServices

class ReviewUploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var reviewTextField: UITextView!
    @IBOutlet weak var reviewImageView: UIImageView!
    
    let imagePicker : UIImagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func reviewUploadButton(_ sender: UIButton) {
        
    }
    
    @IBAction func cameraCall(_ sender: UIButton) {
        print("cameraCall : start")
        
        print("isSourceTypeAvailable : \(UIImagePickerController.isSourceTypeAvailable(.camera))")
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            imagePicker.mediaTypes = [kUTTypeImage] as [String]
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("imagePickerController : start")
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        print("mediaType : \(mediaType)")
        let cameraImage : UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        reviewImageView.image = cameraImage
        
        self.dismiss(animated: false, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("imagePickerControllerDidCancel : start")
        self.dismiss(animated: false, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
