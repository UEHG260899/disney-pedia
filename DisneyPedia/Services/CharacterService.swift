//
//  CharacterService.swift
//  DisneyPedia
//
//  Created by Uriel Hernandez Gonzalez on 10/08/22.
//

import Foundation
import RxSwift


struct CharacterService: NetworkServiceType, CharacterServiceType {
    
    func buildRequest(method: Networker.HTTPMethods, path: String, parameters: [String : String] = [:]) -> URLRequest {
        var components = components
        components.path = path
        components.queryItems = parameters.map { URLQueryItem(name: $0, value: $1) }
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue
        return request
    }
    
    func character(id: Int64) -> Observable<DisneyCharacter> {
        let request = buildRequest(method: .get, path: "/characters/\(id)")
        return Networker.decodable(request: request, type: DisneyCharacter.self)
    }
    
    func image(for url: String) -> Observable<Data> {
        guard let url = URL(string: url) else {
            return Observable.of(Data())
        }
        
        let request = URLRequest(url: url)
        
        return Networker.data(request: request)
    }
    
    
}
