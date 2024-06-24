//
//  GeneralImages.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 22/06/24.
//

import UIKit

final class GlobalImages {
    
    enum Icons: String {

        case next = "ic_arrow-right"
        case eyeHidden = "ic_eye-hidden"
        case filter = "ic_filter"
        case credit = "ic_arrow-down-in"
        case debit = "ic_arrow-up-out"
        
        func getImage() -> UIImage {
            return UIImage(named: self.rawValue) ?? UIImage()
        }
    }
    
}
