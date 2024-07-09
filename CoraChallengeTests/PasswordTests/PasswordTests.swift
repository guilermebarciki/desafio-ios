//
//  PasswordTests.swift
//  CoraChallengeTests
//
//  Created by Guilerme Barciki on 07/07/24.
//

import XCTest
@testable import CoraChallenge

final class PasswordViewModelTests: XCTestCase {
    
    var viewModel: PasswordViewModel!
    var mockDelegate: MockPasswordDelegate!
    var mockWorker: MockLoginWorker!
    var asyncSchedulerFactorySpy: AsyncSchedulerFactorySpy!
    
    override func setUp() {
        super.setUp()
        mockDelegate = MockPasswordDelegate()
        mockWorker = MockLoginWorker()
        asyncSchedulerFactorySpy = AsyncSchedulerFactorySpy()
        viewModel = PasswordViewModel(delegate: mockDelegate, worker: mockWorker, asyncSchedulerFactory: asyncSchedulerFactorySpy)
    }
    
    override func tearDown() {
        viewModel = nil
        mockDelegate = nil
        mockWorker = nil
        asyncSchedulerFactorySpy = nil
        super.tearDown()
    }
    
    func testValidatePassword_WithValidPassword_ShouldActivateLoginButton() {
        // Given
        let validPassword = "123456"
        
        // When
        viewModel.validatePassword(validPassword)
        
        // Then
        XCTAssertEqual(mockDelegate.isLoginButtonActive, true)
    }
    
    func testValidatePassword_WithInvalidPassword_ShouldDeactivateLoginButton() {
        // Given
        let invalidPassword = "12345"
        
        // When
        viewModel.validatePassword(invalidPassword)
        
        // Then
        XCTAssertEqual(mockDelegate.isLoginButtonActive, false)
    }
    
    func testPrepareForNavigation_ShouldSetCPF() {
        // Given
        let cpf = "12345678909"
        
        // When
        viewModel.prepareForNavigation(with: cpf)
        
        // Then
        XCTAssertEqual(viewModel.cpf, cpf)
    }
    
    func testCleanToken_ShouldCallCleanTokenOnWorker() {
        // When
        viewModel.cleanToken()
        
        // Then
        XCTAssertTrue(mockWorker.cleanTokenCalled)
    }
    
    func testSignIn_WithValidCredentials_ShouldCallSignInSuccess() async {
        // Given
        let cpf = "12345678909"
        let password = "123456"
        mockWorker.loginResult = .success(())
        
        viewModel.prepareForNavigation(with: cpf)
        viewModel.validatePassword(password)
        
        // When
        viewModel.signIn()
        await asyncSchedulerFactorySpy.executeLast()
        
        // Then
        XCTAssertTrue(mockDelegate.signInSuccessCalled)
    }
    
    func testSignIn_WithInvalidCredentials_ShouldCallSignInFail() async {
        // Given
        let cpf = "12345678909"
        let password = "123456"
        let error = NetworkError.unauthorized
        mockWorker.loginResult = .failure(error)
        
        viewModel.prepareForNavigation(with: cpf)
        viewModel.validatePassword(password)
        
        // When
        viewModel.signIn()
        await asyncSchedulerFactorySpy.executeLast()
        // Then
        XCTAssertTrue(mockDelegate.signInFailCalled)
    }
    
}
