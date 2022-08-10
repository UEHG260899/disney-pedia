//
//  CharacterListService.swift
//  DisneyPedia
//
//  Created by Uriel Hernandez Gonzalez on 07/08/22.
//

import Foundation
import RxSwift

struct CharacterListService: NetworkServiceType, CharacterListServiceType {

    func buildRequest(method: Networker.HTTPMethods, path: String, parameters: [String : String] = [:]) -> URLRequest {
        var components = components
        components.path = path
        components.queryItems = parameters.map {  URLQueryItem(name: $0, value: $1) }
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue
        return request
    }
    
    func characters(page: Int) -> Observable<CharacterList> {
        let params = [
            "page": String(page)
        ]
        
        let request = buildRequest(method: .get, path: "/characters", parameters: params)
        
        return Networker.decodable(request: request, type: CharacterList.self)
    }
}
