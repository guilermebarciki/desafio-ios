//
//  LoginWorkerTests.swift
//  CoraChallengeTests
//
//  Created by Guilerme Barciki on 09/07/24.
//

import XCTest
@testable import CoraChallenge

final class LoginWorkerTests: XCTestCase {
    
    var sut: LoginWorker!
    var mockAuthService: MockAuthService!
    var mockTokenStorage: MockTokenStorage!
    
    override func setUp() {
        super.setUp()
        mockAuthService = MockAuthService()
        mockTokenStorage = MockTokenStorage()
        sut = LoginWorker(authService: mockAuthService, tokenStorage: mockTokenStorage)
    }
    
    override func tearDown() {
        sut = nil
        mockAuthService = nil
        mockTokenStorage = nil
        super.tearDown()
    }
    
    func testLogin_Success() async {
        // Given
        let expectedToken = "test_token"
        mockAuthService.loginResult = .success(expectedToken)
        
        // When
        let result = await sut.login(cpf: "12345678909", password: "password")
        
        // Then
        switch result {
        case .success:
            XCTAssertEqual(mockTokenStorage.savedToken, expectedToken)
        case .failure:
            XCTFail("Expected success but got failure")
        }
    }
    
    func testLogin_Failure() async {
        // Given
        let expectedError = NetworkError.unauthorized
        mockAuthService.loginResult = .failure(expectedError)
        
        // When
        let result = await sut.login(cpf: "12345678909", password: "password")
        
        // Then
        switch result {
        case .success:
            XCTFail("Expected failure but got success")
        case .failure(let error):
            XCTAssertNotNil(error)
        }
    }
    
    func testCleanToken() {
        // Given
        let token = "test_token"
        mockTokenStorage.saveToken(token)
        
        // When
        sut.cleanToken()
        
        // Then
        XCTAssertEqual(mockTokenStorage.savedToken, "")
    }
}
