//
//  AddCoffeeOrderViewModel.swift
//  CofeeApp
//
//  Created by Jefin on 26/04/20.
//  Copyright © 2020 Jefin. All rights reserved.
//

import Foundation

struct AddCoffeeOrderViewModel {
    
    var name : String?
    
    var email : String?
    
    
    var types: [String] {
        
        return CoffeeType.allCases.map { $0.rawValue.capitalized }
    }
  
    var sizes: [String] {
        
        return CoffeeSize.allCases.map { $0.rawValue.capitalized }
    }
}
