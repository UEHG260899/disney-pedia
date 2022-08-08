//
//  CharacterListViewModel.swift
//  DisneyPedia
//
//  Created by Uriel Hernandez Gonzalez on 06/08/22.
//

import Foundation
import RxSwift
import RxCocoa

struct CharacterListViewModel {
    
    let characterListService: CharacterListServiceType
    let sceneCoordinator: SceneCoordinatorType
    
    
    /// The greeting that shows at the beginning of execution
    let firstGreeting: Observable<String>
    /// A greeting that is calculated every minute
    let continousGreeting: Observable<String>
    /// A greeting with an initial value (firstGreeting) and a continous one calculated (continousGreeting)
    let greeting: Driver<String>
    
    init(characterListService: CharacterListServiceType, sceneCoordinator: SceneCoordinatorType) {
        self.characterListService = characterListService
        self.sceneCoordinator = sceneCoordinator
        
        self.firstGreeting = Observable.create({ observer in
            let date = Date()
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: date)
            
            if hour < 12 {
                observer.onNext("¡Buenos días!")
                observer.onCompleted()
            }
            
            observer.onNext("¡Buenas tardes!")
            observer.onCompleted()
            
            return Disposables.create()
        })
        
        self.continousGreeting = Observable<Int>
            .interval(.seconds(60), scheduler: MainScheduler.instance)
            .map({ _ -> String in
                let date = Date()
                let calendar = Calendar.current
                let hour = calendar.component(.hour, from: date)
                
                if hour < 12 {
                    return "¡Buenos días!"
                }
                
                return "¡Buenas tardes!"
            })
        
        self.greeting = firstGreeting
            .concat(continousGreeting)
            .asDriver(onErrorJustReturn: "")
        
    }

    
}
