//
//  CharacterListService.swift
//  DisneyPedia
//
//  Created by Uriel Hernandez Gonzalez on 07/08/22.
//

import Foundation
import RxSwift

protocol CharacterListServiceType {
    
    func characters(page: Int) -> Observable<CharacterList>
    
    func image(url: String) -> Observable<Data>

}
