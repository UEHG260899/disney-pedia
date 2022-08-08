//
//  NetworkServiceType.swift
//  DisneyPedia
//
//  Created by Uriel Hernandez Gonzalez on 07/08/22.
//

import Foundation

protocol NetworkServiceType {
    
    var components: URLComponents { get }
    
    func buildRequest(method: Networker.HTTPMethods, path: String, parameters: [String: String]) -> URLRequest
    
}

extension NetworkServiceType {
    
    var components: URLComponents {
        var innerComponents = URLComponents()
        innerComponents.scheme = "https"
        innerComponents.host = "api.disneyapi.dev"
        return innerComponents
    }

}
