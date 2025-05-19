//
//  BuyTableViewCell.swift
//  SHEIN App
//
//  Created by Marwan Mekhamer on 15/05/2025.
//

import UIKit

class BuyTableViewCell: UITableViewCell {

    @IBOutlet weak var ImageTable: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
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
        nameLabel.text = data.name
        priceLabel.text = "\(data.price) $"
        
        if let url = URL(string: data.URLString) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let safedata = data, let image = UIImage(data: safedata) {
                    DispatchQueue.main.async {
                        self.ImageTable.image = image
                    }
                }
            }
            .resume()
        }
    }

}
