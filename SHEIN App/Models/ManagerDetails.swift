//
//  ManagerDetails.swift
//  SHEIN App
//
//  Created by Marwan Mekhamer on 15/05/2025.
//

import Foundation

struct ManagerDetails: Codable {
    var products: [Main]
}

struct Main: Codable {
    var title: String
    var description: String
    var category: String
    var price: Double
    var images: [String]
    var rating: Double
    var stock: Int
}
