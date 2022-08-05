//
//  AppConfigurator.swift
//  DisneyPedia
//
//  Created by Uriel Hernandez Gonzalez on 04/08/22.
//

import UIKit

struct AppConfigurator {
    
    
    static func configureNavigationController() -> UINavigationController {
        let navController = UINavigationController()
        navController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navController.navigationBar.isTranslucent = true
        navController.navigationBar.prefersLargeTitles = false
        navController.navigationBar.barStyle = .black
        navController.navigationBar.shadowImage = UIImage()
        return navController
    }
}
