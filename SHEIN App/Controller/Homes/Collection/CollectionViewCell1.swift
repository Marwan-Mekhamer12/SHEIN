//
//  CollectionViewCell1.swift
//  SHEIN App
//
//  Created by Marwan Mekhamer on 15/05/2025.
//

import UIKit

class CollectionViewCell1: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    func setup(ImageURL: Main) {
        
        name.text = ImageURL.title
        
        if let url = URL(string: ImageURL.images[0]) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let datasafe = data, let image = UIImage(data: datasafe){
                    DispatchQueue.main.async {
                        self.image.image = image
    
                    }
                }
            }
            .resume()
        }
        
    }
    
}
