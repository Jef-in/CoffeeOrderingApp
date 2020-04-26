//
//  Order.swift
//  CofeeApp
//
//  Created by Jefin on 12/04/20.
//  Copyright © 2020 Jefin. All rights reserved.
//

import Foundation

enum CoffeeType : String, Codable, CaseIterable {
    
    case cappuccino
    case latte
    case espressino
    case cortado
}

enum CoffeeSize : String, Codable, CaseIterable {
    
    case small
    case medium
    case large
}

struct Order: Codable {
    
    let name : String
    let email : String
    let type : CoffeeType
    let size : CoffeeSize
    
    
}
