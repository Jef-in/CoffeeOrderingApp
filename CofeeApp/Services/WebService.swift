//
//  WebService.swift
//  CofeeApp
//
//  Created by Jefin on 12/04/20.
//  Copyright © 2020 Jefin. All rights reserved.
//

import Foundation
enum NetworkError: Error{
    
    case DecodingError
    case DomainError
    case URLError
}
struct Resource<T: Codable> {
    
    let url: URL
}

class WebService {
    
    func load<T>(resource:Resource<T>, completion: @escaping (Result<T, NetworkError>) -> Void) {
    
        URLSession.shared.dataTask(with: resource.url) { (data, response, error) in
            
            guard let data = data,error == nil else {
                
                completion(.failure(.DomainError))
                return
            }
            let result = try? JSONDecoder().decode(T.self, from: data)
            
            if let result = result {
                
                DispatchQueue.main.async {
                    
                     completion(.success(result))
                }
               
            } else {
                
                completion(.failure(.DecodingError))
            }
            
        }.resume()
    
}
    
}
