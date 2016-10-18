//
//  VHSViewController.swift
//  VHSCollector
//
//  Created by Stephen on 10/17/16.
//  Copyright © 2016 Stephen. All rights reserved.
//

import UIKit

class VHSViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var vhsImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var addUpdate: UIButton!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    
    var imagePicker = UIImagePickerController()
    var vhs : VHS? = nil
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imagePicker.delegate = self
        
        if vhs != nil {
            vhsImageView.image = UIImage(data: vhs!.image as! Data)
            titleTextField.text = vhs!.title
            
        addUpdate.setTitle("Update", for: .normal)
            
            
        }else {
            deleteButton.isHidden = true
        }

        
    }
   
    @IBAction func photosTapped(_ sender: AnyObject) {
        
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
       let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        vhsImageView.image = image
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func cameraTapped(_ sender: AnyObject) {
        
        imagePicker.sourceType = .camera
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func addVHS(_ sender: AnyObject) {
        
        if vhs != nil {
            vhs!.title = titleTextField.text
            vhs!.image = UIImagePNGRepresentation(vhsImageView.image!) as NSData?
            }else {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let vhs = VHS(context: context)
            vhs.title = titleTextField.text
            vhs.image = UIImagePNGRepresentation(vhsImageView.image!) as NSData?
            
            
        }
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
        
    }

    @IBAction func deleteTapped(_ sender: AnyObject) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        context.delete(vhs!)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)    }


}
