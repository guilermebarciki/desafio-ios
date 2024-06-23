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
        
        func getImage() -> UIImage {
            return UIImage(named: self.rawValue) ?? UIImage()
        }
    }
    
}
