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
        let digits = self.digits.compactMap { Int(String($0)) }
        if digits.count != 11 { return false }
        var sum = 0
        for i in 0..<9 {
            let digit = digits[i]
            sum += digit * (10-i)
        }
        var (_, remainder) = (sum * 10).quotientAndRemainder(dividingBy: 11)
        if remainder == 10 { remainder = 0 }
        if remainder != digits[9] { return false }
        sum = 0
        for i in 0..<10 {
            let digit = digits[i]
            sum += digit * (11-i)
        }
        (_, remainder) = (sum * 10).quotientAndRemainder(dividingBy: 11)
        if remainder == 10 { remainder = 0 }
        if remainder != digits[10] { return false }
        return true
    }
    
}
