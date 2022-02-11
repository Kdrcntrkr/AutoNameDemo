//
//  NetworkManagerTests.swift
//  AutoDemoTests
//
//  Created by Kadircan Türker on 20.09.2021.
//

import XCTest
@testable import AutoDemo

class NetworkManagerTests: XCTestCase {
    
    var sut: NetworkManager!
    var session: MockURLSession!
    var url: URL!
    var result: FetchManifacturer.Response!
    
    override func setUp() {
        super.setUp()
        url = URL(fileURLWithPath: "url")
        session = MockURLSession()
        sut = NetworkManager(urlSession: session)
    }
    
    override func tearDown() {
        sut = nil
        session = nil
        url = nil
        super.tearDown()
    }
    
    func test_ShouldReturnDataFromManufacturer() {
        // Given
        let fetchDataExpectation = expectation(description: "Fetch Data")

        let data = FetchManifacturer.Response(wkda: ["": ""])
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)

        session.data = try? JSONEncoder().encode(data)
        session.response = response
        sut = NetworkManager(urlSession: session)
        // When
        let request = FetchManifacturer.Request(page: 0, pageSize: 0)
        sut.sendRequest(request: .fetchManifacturer(request), responseType: FetchManifacturer.Response.self) { result in
            if case let .success(data) = result {
                self.result = data
            }
            fetchDataExpectation.fulfill()
        }

        //Then
        wait(for: [fetchDataExpectation], timeout: 1)
        XCTAssertNotNil(result)
    }
    
    class MockURLSession: URLSession {
        var data: Data?
        var response: URLResponse?
        var error: Error?

        override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            let data = self.data
            let response = self.response
            let error = self.error

            return URLSessionDataTaskMock {
                completionHandler(data, response, error)
            }
        }
    }

    class URLSessionDataTaskMock: URLSessionDataTask {
        private let closure: () -> Void
        init(closure: @escaping () -> Void) {
            self.closure = closure
        }

        override func resume() {
            closure()
        }
    }

}
