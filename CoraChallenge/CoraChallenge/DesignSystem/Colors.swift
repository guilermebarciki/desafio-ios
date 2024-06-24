//
//  Colors.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 12/06/24.
//

import UIKit

import UIKit

public final class Colors {

    private static func get(named name: String) -> UIColor {
        return UIColor(named: name, in: Bundle(for: Colors.self), compatibleWith: nil) ?? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }

    public enum Brand: String {
        case primary

        public var color: UIColor {
            return Colors.get(named: self.rawValue)
        }
    }
    
    public enum Highlight: String {
        case blue

        public var color: UIColor {
            return Colors.get(named: self.rawValue)
        }
    }

    public enum Neutral: String {
        case gray01
        case gray02
        case gray03
        case black
        case white

        public var color: UIColor {
            return Colors.get(named: self.rawValue)
        }
    }

}
