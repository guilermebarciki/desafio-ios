//
//  SignInTests.swift
//  CoraChallengeTests
//
//  Created by Guilerme Barciki on 07/07/24.
//

import XCTest
@testable import CoraChallenge

class SignInViewModelTests: XCTestCase {
    
    var viewModel: SignInViewModel!
    var mockDelegate: MockSignInDelegate!
    
    override func setUp() {
        super.setUp()
        mockDelegate = MockSignInDelegate()
        viewModel = SignInViewModel(delegate: mockDelegate)
    }
    
    override func tearDown() {
        viewModel = nil
        mockDelegate = nil
        super.tearDown()
    }
    
    func testValidateCPF_WithValidCPF_ShouldStoreCPFAndActivateButton() {
        // Given
        let validCPF = "735.485.890-06"
        
        // When
        viewModel.validateCPF(validCPF)
        
        // Then
        XCTAssertNotNil(viewModel.getCPF())
        XCTAssertTrue(mockDelegate.isNavigationButtonActive)
    }
    
    func testValidateCPF_WithInvalidCPF_ShouldNotStoreCPFAndDeactivateButton() {
        // Given
        let invalidCPF = "111.111.111-11"
        
        // When
        viewModel.validateCPF(invalidCPF)
        
        // Then
        XCTAssertNil(viewModel.getCPF())
        XCTAssertFalse(mockDelegate.isNavigationButtonActive)
    }
    
    func testValidateCPF_WithNilValue_ShouldDeactivateButton() {
        // Given
        let nilValue: String? = nil
        
        // When
        viewModel.validateCPF(nilValue)
        
        // Then
        XCTAssertFalse(mockDelegate.isNavigationButtonActive)
    }
    
    func testValidateCPF_WithEmptyValue_ShouldNotStoreCPFAndDeactivateButton() {
        // Given
        let emptyValue = ""
        
        // When
        viewModel.validateCPF(emptyValue)
        
        // Then
        XCTAssertNil(viewModel.getCPF())
        XCTAssertFalse(mockDelegate.isNavigationButtonActive)
    }
    
}

