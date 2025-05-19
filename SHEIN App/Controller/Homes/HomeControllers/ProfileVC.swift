//
//  ProfileVC.swift
//  SHEIN App
//
//  Created by Marwan Mekhamer on 15/05/2025.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var imageuser: UIButton!
    @IBOutlet weak var nameUserLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageuser.layer.cornerRadius = 80
        imageuser.clipsToBounds = true
        imageuser.imageView?.contentMode = .scaleAspectFit // Show the whole image
        imageuser.imageView?.clipsToBounds = true
        
    }
    

    @IBAction func userPhotoPressed(_ sender: UIButton) {
        alertChangeImage()
    }
    
    func alertChangeImage() {
        let alert = UIAlertController(title: "Change your profile picture.", message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Change", style: .default, handler: { _ in
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            picker.allowsEditing = true
            self.present(picker, animated: true)
        }))
        
        present(alert, animated: true)
    }
    
    @IBAction func goToCart(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "buy") as? BuyVC {
            present(vc, animated: true)
        }
    }
    
    
    @IBAction func goToLikeVC(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "like") as? LikeVC {
            present(vc, animated: true)
        }
    }
    
    
    @IBAction func LogOUT(_ sender: UIButton) {
        
        // LogOut by firebase Auth
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "nav") as? NavigationViewController {
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
        
    }
    
}


extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var selectedImage: UIImage?
        
        if let editedImage = info[.editedImage] as? UIImage {
            selectedImage = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            selectedImage = originalImage
        }

        if let image = selectedImage {
            imageuser.setImage(image, for: .normal)
        }
        
        dismiss(animated: true)
    }
}
