//
//  SceneCoordinator.swift
//  DisneyPedia
//
//  Created by Uriel Hernandez Gonzalez on 06/08/22.
//

import UIKit
import RxSwift

class SceneCoordinator: SceneCoordinatorType {
    
    
    private var window: UIWindow
    private var currentViewController: UIViewController
    
    required init(window: UIWindow) {
        self.window = window
        currentViewController = UIViewController()
    }
    
    @discardableResult
    func transition(to scene: Scene, type: SceneTransitionType, withNavController: Bool = false) -> Completable {
        let subject = PublishSubject<Void>()
        let viewController = scene.viewController()
        
        switch type {
        case .root:
            
            if withNavController {
                let navController = AppConfigurator.configureNavigationController()
                navController.setViewControllers([viewController], animated: false)
                window.rootViewController = navController
                currentViewController = viewController
                subject.onCompleted()
                break
            }
            
            currentViewController = viewController
            window.rootViewController = viewController
            subject.onCompleted()
        case .push:
            subject.onCompleted()
        case .modal:
            subject.onCompleted()
        }
        
        return subject
            .asObservable()
            .take(1)
            .ignoreElements()
            .asCompletable()
    }
    
    @discardableResult
    func pop(animated: Bool) -> Completable {
        return Completable.create { completable in
            return Disposables.create()
        }
    }
    
    
}
