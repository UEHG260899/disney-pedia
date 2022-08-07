//
//  ReuableCellType.swift
//  DisneyPedia
//
//  Created by Uriel Hernandez Gonzalez on 07/08/22.
//

import UIKit

protocol ReusableCellType {
    /// Generated UINib for registering
    static var nib: UINib { get }
    
    
    /// Cell identifier
    static var identifier: String { get }
}

extension ReusableCellType {
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: .main)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
