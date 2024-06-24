//
//  HomeImages.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 12/06/24.
//

import UIKit

final class HomeImages {
    
    enum General: String {

        case banner = "home-image"
        case logo = "cora-logo"
        
        func getImage() -> UIImage {
            return UIImage(named: self.rawValue) ?? UIImage()
        }
    }
    
}
