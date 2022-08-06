//
//  SceneCoordinatorType.swift
//  DisneyPedia
//
//  Created by Uriel Hernandez Gonzalez on 04/08/22.
//

import Foundation
import RxSwift

protocol SceneCoordinatorType {
    
    
    @discardableResult
    /// Function that manages transitions between views
    /// - Parameters:
    ///   - scene: Scene where the view resides
    ///   - type: root, push, modal transitions
    ///   - withNavController: Only used when type is root
    /// - Returns: Operation Completion
    func transition(to scene: Scene, type: SceneTransitionType, withNavController: Bool) -> Completable
    
    @discardableResult
    /// Function that pops the currently displayed ViewController
    /// - Parameter animated: Wheter it should be animated or not
    /// - Returns: Operation completion
    func pop(animated: Bool) -> Completable
}

extension SceneCoordinatorType {
    @discardableResult
    
    /// Default implementation for pop, calls pop(animated:) with true parameter
    /// - Returns: <#description#>
    func pop() -> Completable {
        return pop(animated: true)
    }
}
