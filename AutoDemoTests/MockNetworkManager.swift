//
//  MockNetworkManager.swift
//  AutoDemoTests
//
//  Created by Kadircan Türker on 20.09.2021.
//

import Foundation
@testable import AutoDemo

class MockNetworkManager: NetworkManager {
    enum Status { case success, error }
    enum DataType { case manufacturer, carTypes }
    var status: Status = .success
    var dataType: DataType = .manufacturer
    
    override func sendRequest<T>(request: Request, responseType: T.Type, completion: @escaping ((Result<T, NetworkError>) -> Void)) where T : Decodable {
        switch status {
        case .success:
            switch dataType {
            case .manufacturer:
                completion(.success(getManufacturerData() as! T))
            case .carTypes:
                completion(.success(getCarTypesData() as! T))
            }
        case .error:
            completion(.failure(.somethingWentWrong(nil)))
        }
    }
    
    func getManufacturerData() -> FetchManifacturer.Response {
        return FetchManifacturer.Response(wkda: ["":""])
    }
    
    func getCarTypesData() -> FetchCarTypes.Response {
        return FetchCarTypes.Response(wkda: ["":""])
    }
}
