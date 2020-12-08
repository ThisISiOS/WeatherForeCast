//
//  NetworkManager.swift
//  WeatherForeCastApp
//
//  Created by Hetal Patel on 06/12/20.
//  Copyright © 2020 Hetal Patel. All rights reserved.
//

import Foundation

public enum APIServiceError: Error {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case decodeError
}

class NetworkManager {
    // MARK: - Properties
    static let shared = NetworkManager()
    var baseURL : String {
        switch WFAppManager.shared.appStatus {
        case .production:
            return "http://api.openweathermap.org/data/2.5/"
        case .staging:
            return "http://api.openweathermap.org/data/2.5/"
        case .local:
            return "http://api.openweathermap.org/data/2.5/"
        }
    }
   

    private let urlSession = URLSession.shared
    private let jsonDecoder: JSONDecoder = {
       let jsonDecoder = JSONDecoder()
       jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
       let dateFormatter = DateFormatter()
       dateFormatter.dateFormat = "yyyy-mm-dd"
       jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
       return jsonDecoder
    }()

    func fetchResources<T: Decodable>(endPointUrl: String, completion: @escaping (Result<T, APIServiceError>) -> Void) {
        let urlString =  endPointUrl
        let url = URL(string: urlString)!
        guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            completion(.failure(.invalidEndpoint))
            return
        }
//        let queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
//        urlComponents.queryItems = queryItems
        
        guard let finalUrl = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
     
        urlSession.dataTask(with: finalUrl) { (data, response, error) in
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            do {
                if let data = data {
                    let values = try self.jsonDecoder.decode(T.self, from: data)
                    completion(.success(values))
                }
            } catch {
                completion(.failure(.decodeError))
            }
            if error != nil {
                completion(.failure(.apiError))
            }
         }.resume()
    }
}
