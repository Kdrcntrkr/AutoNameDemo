//
//  CarsBusinessController.swift
//  AutoDemo
//
//  Created by Kadircan Türker on 20.09.2021.
//

import Foundation

class CarsBusinessController {
    let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func fetchCarTypes(with key: String, then handler: @escaping ((Result<[CarTypeModel], NetworkError>) -> Void)) {
        let request = FetchCarTypes.Request(manufacturerKey: key)
        networkManager.sendRequest(request: .fetchCarTypes(request), responseType: FetchCarTypes.Response.self) { result in
            switch result {
            case .success(let response):
                let models = response.wkda.map({ return CarTypeModel(id: $0.key, carType: $0.value)})
                handler(.success(models))
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
}
