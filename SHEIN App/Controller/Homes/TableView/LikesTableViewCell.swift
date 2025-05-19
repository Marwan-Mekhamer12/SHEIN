//
//  LikesTableViewCell.swift
//  SHEIN App
//
//  Created by Marwan Mekhamer on 17/05/2025.
//

import UIKit

class LikesTableViewCell: UITableViewCell {

    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(data: CartItem) {
        titleLabel.text = data.name
        priceLabel.text = "\(data.price) $"
        
        if let url = URL(string: data.URLString) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let safedata = data, let image = UIImage(data: safedata) {
                    DispatchQueue.main.async {
                        self.photoImage.image = image
                    }
                }
            }
            .resume()
        }
    }

}
