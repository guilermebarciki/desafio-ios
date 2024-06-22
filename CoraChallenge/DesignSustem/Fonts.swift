//
//  Fonts.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 21/06/24.
//

import UIKit

enum CoraFontName {
    static let regular = "Avenir-Book"
    static let bold = "Avenir-Heavy"
}

enum CoraFontSize {
    case title1
    case title2
    case body1
    case body2
    case body3

    var size: CGFloat {
        switch self {
        case .title1: return 28
        case .title2: return 22
        case .body1: return 16
        case .body2: return 14
        case .body3: return 12
        }
    }
}

extension UIFont {
    static func regular(_ size: CoraFontSize) -> UIFont? {
        return UIFont(name: CoraFontName.regular, size: size.size)
    }
    
    static func bold(_ size: CoraFontSize) -> UIFont? {
        return UIFont(name: CoraFontName.bold, size: size.size)
    }
}
