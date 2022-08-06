//
//  AppDelegate.swift
//  DisneyPedia
//
//  Created by Uriel Hernandez Gonzalez on 04/08/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let sceneCoordinator = SceneCoordinator(window: window!)
        
        let characterListViewModel = CharacterListViewModel()
        let firstScene = Scene.characterList(characterListViewModel)
        
        sceneCoordinator.transition(to: firstScene, type: .root, withNavController: true)
        window?.makeKeyAndVisible()
        return true
    }
    
}

