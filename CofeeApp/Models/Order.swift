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

extension Order {
    
    static var all: Resource<[Order]> = {
        
            guard let url = URL(string: "https://guarded-retreat-82533.herokuapp.com/orders") else { fatalError("Error in the url") }
        
        return Resource<[Order]>(url: url)
        
    }()
    
   static func create(vm:AddCoffeeOrderViewModel) -> Resource<Order?> {
        
      let order = Order(vm)
    
    guard let url = URL(string: "https://guarded-retreat-82533.herokuapp.com/orders") else { fatalError("Error in the url") }
    
    guard let data = try? JSONEncoder().encode(order) else {
        
        fatalError("Error encoding JSON")
    }
    
    var resource = Resource<Order?>(url: url)
    resource.method = HttpMethod.post
    resource.body = data
    
    return resource
    
    }
}

extension Order {
    init?(_ vm: AddCoffeeOrderViewModel) {
        
        guard let name = vm.name,
            let email = vm.email,
            let SelectedSize = CoffeeSize(rawValue: vm.CofeeSize!.lowercased()),
            let SelectedType = CoffeeType(rawValue: vm.CofeeType!.lowercased()) else {
           
            return nil
        }
        
        self.name = name
        self.email = email
        self.size = SelectedSize
        self.type = SelectedType
    }
    
}
