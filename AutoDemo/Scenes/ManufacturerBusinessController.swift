//
//  ManufacturerBusinessController.swift
//  AutoDemo
//
//  Created by Kadircan Türker on 19.09.2021.
//

import Foundation

class ManufacturerBusinessController {
    let networkManager: NetworkManager
    private var pageNumber = 0
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func fetchManufacturers(handler: @escaping ((Result<[ManufacturerModel], NetworkError>) -> Void)) {
        let request = FetchManifacturer.Request(page: pageNumber, pageSize: 15)
        networkManager.sendRequest(request: .fetchManifacturer(request), responseType: FetchManifacturer.Response.self) { result in
            switch result {
            case .success(let response):
                let models = response.wkda.map({ return ManufacturerModel(id: $0.key, name: $0.value)})
                self.pageNumber = self.pageNumber + 1
                handler(.success(models))
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
    
}
