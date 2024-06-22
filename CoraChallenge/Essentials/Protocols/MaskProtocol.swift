//
//  MaskProtocol.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 22/06/24.
//

import UIKit

public protocol MaskProtocol {
    
    var maskFormat: String { get set }
    func applyMask(for value: String?) -> String?
    
}

public extension MaskProtocol {
    
    func applyMask(for value: String?) -> String? {
        guard let value = value else { return nil }
        let cleanValue = value.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        var result: String = ""
        var index = cleanValue.startIndex
        for character in maskFormat where index < cleanValue.endIndex {
            if character == "#" {
                result.append(cleanValue[index])
                index = cleanValue.index(after: index)
            } else {
                result.append(character)
            }
        }
        return result
    }
    
    func shouldChangeCharactersIn(_ textField: UITextField, range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let value = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = applyMask(for: value)
        return false
    }
    
}
