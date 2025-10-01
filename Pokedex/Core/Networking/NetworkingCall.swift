//
//  APIClient.swift
//  Pokedex
//
//  Created by Bruno Madeira on 29/09/2025.
//

import Foundation
import Alamofire
import UIKit

struct Endpoint {
    let url: URL
    let method: String = "GET"
}

enum NetworkError: Error {
    
    case badResponse
    case badStatusCode(Int)
    case badData
}

class NetworkingCall {
    
    static let shared = NetworkingCall()
    private let session: URLSession
    var dataImage = UIImage()
    
    init() {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }
    
    
    func responseCall<T: Codable>(url: String, responseType: T.Type) async throws -> T {
        guard let url = URL(string: url) else {
            throw NetworkError.badResponse
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.badResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.badStatusCode(httpResponse.statusCode)
        }
        
        let decodedResponse = try JSONDecoder().decode(responseType, from: data)
        return decodedResponse
    }

    
    func fetchImage(url: String, completion: @escaping (UIImage?, Error?) -> ()) {
        
        AF.request(url).responseData { response in
            
            if let dataImage = response.data {
                let imageData = UIImage(data: dataImage)
                completion(imageData, nil)
            } else {
                completion(nil, response.error)
            }
        }
    }
}

