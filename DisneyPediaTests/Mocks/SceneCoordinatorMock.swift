//
//  SceneCoordinatorMock.swift
//  DisneyPediaTests
//
//  Created by Uriel Hernandez Gonzalez on 07/08/22.
//

import Foundation
import RxSwift
@testable import DisneyPedia

struct SceneCoordinatorMock: SceneCoordinatorType {
    
    func transition(to scene: Scene, type: SceneTransitionType, withNavController: Bool) -> Completable {
        return Completable.create { completable in
            return Disposables.create()
        }
    }
    
    func pop(animated: Bool) -> Completable {
        return Completable.create { completable in
            return Disposables.create()
        }
    }
    
    
}
