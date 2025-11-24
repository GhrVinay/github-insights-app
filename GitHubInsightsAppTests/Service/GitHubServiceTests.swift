//
//  GitHubServiceTests.swift
//  GitHubInsightsAppTests
//
//  Created by GHR Vinay on 22/11/25.
//

import XCTest
@testable import GitHubInsightsApp


class MockURLSession: URLSessionProtocol {
    var someData: Data?
    var someResponse: URLResponse?
    var someError: Error?
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error = someError { throw error }
        if let data = someData, let response = someResponse { return (data, response) }
        return (Data(), URLResponse())
    }
}

final class GitHubServiceTests: XCTestCase {
    private var successData: Data?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let testBundle = Bundle(for: type(of: self))
        guard let url = testBundle.url(forResource: "successResponse", withExtension: "json") else {
            XCTFail("Missing file: successResponse.json")
            return
        }
        successData = try Data(contentsOf: url)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func test_fetchTrendingRepos_success() async {
        let mock = MockURLSession()
        mock.someData = successData
        mock.someResponse = HTTPURLResponse(url: URL(string: "https://api.github.com/search/repositories")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let service = await GitHubService(session: mock)
        
        do {
            let result: [RepoDetail] = try await service.fetchTrendingRepostoriesByLanguage(lang: "java")
            XCTAssertEqual(result.count, 30)
        } catch {
            XCTFail("Expected success but got error: \(error)")
        }
    }
    
    func test_fetchTrendingRepos_invalidStatusCode() async {
        let mock = MockURLSession()
        mock.someData = successData
        mock.someResponse = HTTPURLResponse(url: URL(string: "https://api.github.com/search/repositories")!, statusCode: 400, httpVersion: nil, headerFields: nil)
        
        let service = await GitHubService(session: mock)
        
        do {
            let result: [RepoDetail] = try await service.fetchTrendingRepostoriesByLanguage(lang: "java")
            XCTFail("Expected GitHubServiceError but got: \(result)")
        } catch let err as GitHubServiceError {
            XCTAssertEqual(err, .invalidStatusCode)
        } catch {
            XCTFail("Expected GitHubServiceError.invalidStatusCode but got: \(error)")
        }
    }
}
