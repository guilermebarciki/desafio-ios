//
//  DateHeaderFill.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 23/06/24.
//

import Foundation

struct DateHeaderFill {
    
    var formattedDate: String
    
    static func getFrom(date: String) -> DateHeaderFill? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let dateObject = inputFormatter.date(from: date) else {
            return nil
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "EEEE - d 'de' MMMM"
        outputFormatter.locale = Locale(identifier: "pt_BR")
        
        let formattedDate = outputFormatter.string(from: dateObject).capitalized
        
        return DateHeaderFill(formattedDate: formattedDate)
    }
    
}
