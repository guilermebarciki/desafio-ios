//
//  Colors.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 12/06/24.
//

import UIKit

public final class Colors {
    
    public enum Brand: String {
        case primary
        
        public func get() -> UIColor {
            return UIColor(named: self.rawValue, in: Bundle(for: Colors.self), compatibleWith: nil) ?? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    
    public enum Neutral: String {

        case gray01
        case gray02
        case gray03
        case black
        
        public func get() -> UIColor {
            return UIColor(named: self.rawValue, in: Bundle(for: Colors.self), compatibleWith: nil) ?? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    
    public enum Background: String {

        case white
        
        public func get() -> UIColor {
            return UIColor(named: self.rawValue, in: Bundle(for: Colors.self), compatibleWith: nil) ?? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    
}

