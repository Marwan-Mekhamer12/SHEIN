//
//  PayNowVC.swift
//  SHEIN App
//
//  Created by Marwan Mekhamer on 18/05/2025.
//

import UIKit

class PayNowVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func VIsaActionPressed(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "visa") as? VisaPayVC {
            vc.title = "Visa Pay"
            vc.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    @IBAction func PayPalActionPressed(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "paypal") as? PayPalPayVC {
            vc.title = "PayPal Pay"
            vc.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}
