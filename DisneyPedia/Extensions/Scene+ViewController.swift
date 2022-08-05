//
//  Scene+ViewController.swift
//  DisneyPedia
//
//  Created by Uriel Hernandez Gonzalez on 04/08/22.
//

import UIKit

extension Scene {
    func viewController() -> UIViewController {
        switch self {
        case .characterList(let characterListViewModel):
            // TODO: Instanciate CharacterListViewController
            return UIViewController()
        case .character(let characterViewModel):
            // TODO: Instanciate CharacterViewModel
            return UIViewController()
        }
    }
}
