//
//  CharacterServiceType.swift
//  DisneyPedia
//
//  Created by Uriel Hernandez Gonzalez on 10/08/22.
//

import Foundation
import RxSwift

protocol CharacterServiceType {
    
    
    /// Fetches the character info
    /// - Parameter id: Character id
    /// - Returns: Observable with the response data
    func character(id: Int64) -> Observable<DisneyCharacter>
    
    /// Fetches character image
    /// - Parameter url: Image url
    /// - Returns: Observable with the image data
    func image(for url: String) -> Observable<Data>
    
}
