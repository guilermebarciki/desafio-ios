//
//  String+Extensions.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 22/06/24.
//

import Foundation

extension String {
    
    var digits: String {
        self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
    
    func stringWithNumbersOnly() -> String {
        return replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression, range: startIndex..<endIndex)
    }
    
    func isValidCPF() -> Bool {
        let numbers = self.compactMap { Int(String($0)) }
        guard numbers.count == 11 else { return false }
        
        let uniqueNumbers = Set(numbers)
        if uniqueNumbers.count == 1 { return false }
        
        let dv1 = calculateDigit(numbers: numbers, end: 9, factor: 10)
        let dv2 = calculateDigit(numbers: numbers, end: 10, factor: 11)
        
        return dv1 == numbers[9] && dv2 == numbers[10]
    }
    
    private func calculateDigit(numbers: [Int], end: Int, factor: Int) -> Int {
        var sum = 0
        for i in 0..<end {
            sum += numbers[i] * (factor - i)
        }
        let mod = sum % 11
        return mod < 2 ? 0 : 11 - mod
    }
    
}
