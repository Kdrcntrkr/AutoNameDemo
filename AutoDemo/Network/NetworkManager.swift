//
//  NetworkManager.swift
//  AutoDemo
//
//  Created by Kadircan Türker on 19.09.2021.
//

import Foundation
import UIKit

class NetworkManager {
    
    let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func sendRequest<T: Decodable>(request: Request, responseType: T.Type, completion: @escaping ((Result<T, NetworkError>) -> Void)) {
        
        guard var urlComponents = URLComponents(string: request.baseURL) else { return completion(.failure(.urlFailure))}
        urlComponents.queryItems = request.parameters
        guard let requestUrl = urlComponents.url else {
            return completion(.failure(.urlFailure))
        }
        
        let request = URLRequest(url: requestUrl)
        
        let task = urlSession.dataTask(with: request) { (data, _, error) in
            if let error = error {
                return completion(.failure(.somethingWentWrong(error)))
            }
            guard let data = data, !data.isEmpty else {
                return completion(.failure(.noData))
            }
            do {
                let response = try JSONDecoder().decode(responseType.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(.parseError))
            }
        }
        task.resume()
    }
}

enum NetworkError: Error {
    case noData
    case somethingWentWrong(Error?)
    case parseError
    case urlFailure
}

protocol RequestProtocol {
    var parameters: [URLQueryItem] { get }
    var baseURL: String { get }
    var method: String { get }
}


internal enum Request: RequestProtocol {
    case fetchManifacturer(FetchManifacturer.Request)
    case fetchCarTypes(FetchCarTypes.Request)
    
    var parameters: [URLQueryItem] {
        switch self {
        case .fetchCarTypes(let request):
            var items = [URLQueryItem]()
            items.append(URLQueryItem(name: "manufacturer", value: request.manufacturerKey))
            items.append(URLQueryItem(name: "wa_key", value: "coding-puzzle-client-449cc9d"))
            return items
        case .fetchManifacturer(let request):
            var items = [URLQueryItem]()
            items.append(URLQueryItem(name: "page", value: "\(request.page)"))
            items.append(URLQueryItem(name: "pageSize", value: "\(request.pageSize)"))
            items.append(URLQueryItem(name: "wa_key", value: "coding-puzzle-client-449cc9d"))
            return items
        }
    }
    
    var baseURL: String {
        switch self {
        case .fetchCarTypes:
            return "https://api-aws-eu-qa-1.auto1-test.com/v1/car-types/main-types"
        case .fetchManifacturer:
            return "https://api-aws-eu-qa-1.auto1-test.com/v1/car-types/manufacturer"
        }
    }
    
    var method: String {
        return "GET"
    }
}
