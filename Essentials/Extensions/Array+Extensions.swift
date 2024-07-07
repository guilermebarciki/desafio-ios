//
//  Array+Extensions.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 23/06/24.
//

import Foundation

extension Array {
    
    func safeFind(at index: Int?) -> Element? {
        guard let index = index else {
            return nil
        }
        
        return index >= 0 && index < count ? self[index] : nil
    }
    
}
