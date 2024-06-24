//
//  UITableViewCell+Extensions.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 23/06/24.
//

import UIKit

public extension UITableViewCell {
    
    class func createCell<T: UITableViewCell>(tableView: UITableView, indexPath: IndexPath) -> T {
        return tableView.dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as? T ?? T()
    }
    
}
