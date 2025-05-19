//
//  CollectionViewCell2.swift
//  SHEIN App
//
//  Created by Marwan Mekhamer on 15/05/2025.
//

import UIKit

class CollectionViewCell2: UICollectionViewCell {
    
    @IBOutlet weak var UiimagePhoto: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func setUp(pro : Main) {
        titleLabel.text = pro.title
        priceLabel.text = "\(pro.price) $"
        
        if let url = URL(string: pro.images[0]) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let safedata = data, let image = UIImage(data: safedata) {
                    DispatchQueue.main.async {
                        self.UiimagePhoto.image = image
                    }
                }
            }
            .resume()
        }
    }
}
