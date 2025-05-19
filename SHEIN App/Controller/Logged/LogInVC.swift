//
//  LogInVC.swift
//  SHEIN App
//
//  Created by Marwan Mekhamer on 14/05/2025.
//

import UIKit

class LogInVC: UIViewController {

    @IBOutlet weak var emailtxt: UITextField!
    @IBOutlet weak var passwordtxt: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        emailtxt.delegate = self
        passwordtxt.delegate = self
    }
    
    @IBAction func logInpressed(_ sender: UIButton) {
        if let email = emailtxt.text, let password = passwordtxt.text,
           !email.isEmpty, !password.isEmpty, password.count >= 6 {
            
            // logIn with Firebase
            if let vc = storyboard?.instantiateViewController(withIdentifier: "tabbar") as? MainTabBar{
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true)
            }
        }else {
            alertLogInpressed()
        }
    }
    
    func alertLogInpressed(){
        let alert = UIAlertController(title: "WOops!", message: "Something is wrong, password must have equal or more 6 letters, please try again!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

// Marwan: - Text Field Delegate

extension LogInVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailtxt{
            passwordtxt.becomeFirstResponder()
        }else {
            view.endEditing(true)
        }
        return true
    }
}
