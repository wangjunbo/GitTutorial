//
//  NewRestaurantController.swift
//  GitTutorial
//
//  Created by wangjunbo on 2019/8/19.
//  Copyright © 2019 wangjunbo. All rights reserved.
//

import UIKit
import CoreData

class NewRestaurantController: UITableViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet var photoImageView:UIImageView!
    var restaurant: RestaurantMO!
    
    var appDelegate:AppDelegate!
    var context:NSManagedObjectContext!
    
    @IBOutlet var nameTextField:RoundedTextField! {
        didSet {
            nameTextField.tag = 1
            nameTextField.becomeFirstResponder()
            nameTextField.delegate = self
        }
    }
    
    @IBOutlet var typeTextField: RoundedTextField! {
        didSet {
            typeTextField.tag = 2
            typeTextField.delegate = self
        }
    }
    
    @IBOutlet var addressTextField: RoundedTextField! {
        didSet {
            addressTextField.tag = 3
            addressTextField.delegate = self
        }
    }
    
    @IBOutlet var phoneTextField: RoundedTextField! {
        didSet {
            phoneTextField.tag = 4
            phoneTextField.delegate = self
        }
    }
    
    @IBOutlet var descriptionTextView: UITextView! {
        didSet {
            descriptionTextView.tag = 5
            descriptionTextView.layer.cornerRadius = 2.0
            descriptionTextView.layer.masksToBounds = true
        }
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
//        Name: Izakaya Sozai
//        Type: Japanese
//        Location: 1500 Irving St San Francisco, CA 94122
//        Phone: (415) 742-5122
//        Description: A great restaurant to try out
        
        let name = nameTextField.text ?? ""
        let type = typeTextField.text ?? ""
        let location = addressTextField.text ?? ""
        let phone = phoneTextField.text ?? ""
        let description = descriptionTextView.text ?? ""
        
//        print("Name:\(name)")
//        print("Type:\(type)")
//        print("Location:\(location)")
//        print("Phone:\(phone)")
//        print("Description:\(description)")
        
        if name == "" || type == "" || location == "" || phone == "" || description == "" {
            
            let alertController = UIAlertController(title: "Oops", message: "We can't proceed because one of the fields is blank. Please note that all fields are required.", preferredStyle: .alert )
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
            
        }
        
        restaurant = RestaurantMO(context: context )
        restaurant.name = name
        restaurant.type = type
        restaurant.location = location
        restaurant.phone = phone
        restaurant.summary = description
        restaurant.isVisited = false
        
        if let restaurantImage = photoImageView.image {
            restaurant.image = restaurantImage.pngData()
        }
        
        print("Saving data to context ...")
        appDelegate.saveContext()
  
        return
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
        
        if let customFont = UIFont(name: "Rubik-Medium", size: 35.0){
            navigationController?.navigationBar.largeTitleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor(red: 231, green: 76, blue: 60,alpha: 1),
                NSAttributedString.Key.font : customFont
            ]
        }
        
        appDelegate = getAppDelegate()
        context = getContext()
    }
    
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let photoSourceRequestController = UIAlertController(title: "", message: "Choose your photo source", preferredStyle: .actionSheet)
            
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { (action) in
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .camera
                    imagePicker.delegate = self
                    self.present(imagePicker, animated: true, completion: nil)
                }
            })
            
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: { (action) in
                
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .savedPhotosAlbum
                    imagePicker.delegate = self
                    self.present(imagePicker,animated: true,completion: nil)
                }
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            
            photoSourceRequestController.addAction(cameraAction)
            photoSourceRequestController.addAction(photoLibraryAction)
            photoSourceRequestController.addAction(cancelAction)
            
            // For iPad
            if let popoverController = photoSourceRequestController.popoverPresentationController {
                if let cell = tableView.cellForRow(at: indexPath) {
                    popoverController.sourceView = cell
                    popoverController.sourceRect = cell.bounds
                }
            }
            present(photoSourceRequestController, animated: true, completion: nil )
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = view.viewWithTag(textField.tag + 1) {
            textField.resignFirstResponder()
            nextTextField.becomeFirstResponder()
        }
        return true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoImageView.image = selectedImage
            photoImageView.contentMode = .scaleAspectFit
            photoImageView.clipsToBounds = true
        }
        
        let leadingConstraint = NSLayoutConstraint(item: photoImageView as? Any, attribute: .leading, relatedBy: .equal , toItem: photoImageView.superview, attribute: .leading, multiplier: 1, constant: 0)
        leadingConstraint.isActive = true
        
        let trailingConstraint = NSLayoutConstraint(item: photoImageView as? Any, attribute: .trailing, relatedBy: .equal, toItem: photoImageView.superview, attribute: .trailing, multiplier: 1, constant: 0)
        trailingConstraint.isActive = true
 
        let topConstraint = NSLayoutConstraint(item: photoImageView as? Any, attribute: .top, relatedBy: .equal, toItem: photoImageView.superview, attribute: .top, multiplier: 1, constant: 0)
        topConstraint.isActive = true
        
        let bottomConstraint = NSLayoutConstraint(item: photoImageView as? Any, attribute: .bottom, relatedBy: .equal, toItem: photoImageView.superview, attribute: .bottom, multiplier: 1, constant: 0)
        bottomConstraint.isActive = true
        
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        performSegue(withIdentifier: "unwindToHome", sender: self)
        
        let now = Date()
        save(UIBarButtonItem())
        let now1 = Date()
        let diff = now1.compare(now)
        print("diff \(diff.rawValue)")
    }

}
