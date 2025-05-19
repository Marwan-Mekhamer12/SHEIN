//
//  WelcomeVC.swift
//  SHEIN App
//
//  Created by Marwan Mekhamer on 14/05/2025.
//

import UIKit

class WelcomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logInPressed(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "login") as? LogInVC{
            vc.modalPresentationStyle = .fullScreen
            vc.title = "LogIn"
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func signUpPressed(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "signup") as? SignUpVC{
            vc.modalPresentationStyle = .fullScreen
            vc.title = "Register"
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
