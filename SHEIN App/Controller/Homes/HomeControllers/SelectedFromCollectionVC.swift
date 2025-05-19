//
//  SelectedFromCollectionVC.swift
//  SHEIN App
//
//  Created by Marwan Mekhamer on 15/05/2025.
//

import UIKit

class SelectedFromCollectionVC: UIViewController {

    @IBOutlet weak var APIImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var StepperValue: UILabel!
    
    
    var photo: String?
    var name: String?
    var price: String?
    var category: String?
    var descriptionyy: String?
    var rating: String?
    var stock: String?
    var basePrice = 0.0
    
    var isLiked = false
    var likeButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        details()
        tabbar()
        
    }
    
    func tabbar() {
        likeButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .done, target: self, action: #selector(like))
        let cartbutton = UIBarButtonItem(image: UIImage(systemName: "cart"), style: .done, target: self, action: #selector(buy))
        
        // Set both bar button items to the right side of the navigation bar
        navigationItem.rightBarButtonItems = [likeButton, cartbutton] // order matters: right-most is last
    }
    
    
    @objc func like() {
        
        isLiked.toggle()
        let icon = isLiked ? "heart.fill" : "heart"
        likeButton.image = UIImage(systemName: icon)
        likeButton.tintColor = .red
        
        // passing data to LikeVC
        
        if isLiked {
            let likeitem = CartItem(URLString: photo ?? "", name: name ?? "", price: Double(price ?? "0") ?? 0.0)
            LikesManager.share.likedItems.append(likeitem)
        }
        
    }
    
    @objc func buy() {
        
        // passing data to Carts
        if let vc = storyboard?.instantiateViewController(withIdentifier: "buy") as? BuyVC {
            vc.title = "Cart"
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func details() {
        if let imageString = photo, let url = URL(string: imageString) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data, let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        self.APIImage.image = image
                    }
                }
            }
            .resume()
        }
        
        titleLabel.text = name
//        priceLabel.text = "\(price ?? "") $"
        categoryLabel.text = category
        descriptionLabel.text = descriptionyy
        ratingLabel.text = "⭐️ \(rating ?? "")"
        stockLabel.text = "\(stock ?? "")"
        
        if let priceString = price, let priceDouble = Double(priceString) {
            basePrice = priceDouble
            priceLabel.text = "\(priceDouble) $"
        }
    }
    
    @IBAction func AddToCart(_ sender: UIButton) {
        
        let quantity = Int(StepperValue.text ?? "1")
        
        if quantity != 0 {
            
            if let image = photo, let name = name {
                let totalPrice = basePrice * Double(quantity ?? 1)
                let item = CartItem(URLString: image, name: name, price: totalPrice)
                
                CartManager.shared.cartItems.append(item)
            }
        }
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "buy") as? BuyVC {
            vc.title = "Carts"
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func stepperValueChange(_ sender: UIStepper) {
        
        let quantity = Int(sender.value)
        
        StepperValue.text = "\(quantity)"
        
        var totalPrice = basePrice
            if quantity != 0 {
                totalPrice *= Double(quantity)
            }
            
            priceLabel.text = "\(String(format: "%.2f", totalPrice)) $"
        
    }
    
}
