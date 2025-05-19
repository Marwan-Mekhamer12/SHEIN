//
//  CartItem.swift
//  SHEIN App
//
//  Created by Marwan Mekhamer on 15/05/2025.
//

import Foundation

struct CartItem {
    var URLString: String
    var name: String
    var price: Double
}

class CartManager {
    static let shared = CartManager()
    private init() {}
    
    var cartItems: [CartItem] = []
}

class LikesManager {
    static let share = LikesManager()
    private init() {}
    
    var likedItems: [CartItem] = []
    
}
