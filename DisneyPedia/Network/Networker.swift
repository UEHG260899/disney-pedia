//
//  Networker.swift
//  DisneyPedia
//
//  Created by Uriel Hernandez Gonzalez on 07/08/22.
//

import Foundation
import RxSwift


struct Networker {
    
    enum NetworkerErrors: Error {
        case unknown
        case invalidResponse(response: URLResponse)
        case requestFailed(response: HTTPURLResponse)
        case deserializationFailed
    }
    
    static func response(request: URLRequest) -> Observable<(HTTPURLResponse, Data)> {
        return Observable.create { observer in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let response = response,
                      let data = data else {
                    observer.onError(error ?? NetworkerErrors.unknown)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    observer.onError(NetworkerErrors.invalidResponse(response: response))
                    return
                }
                
                observer.onNext((httpResponse, data))
                observer.onCompleted()
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    static func data(request: URLRequest) -> Observable<Data> {
        return response(request: request).map { response, data -> Data in
            guard 200..<300 ~= response.statusCode else {
                throw NetworkerErrors.requestFailed(response: response)
            }
            
            return data
        }
    }
    
    static func decodable<T: Decodable>(request: URLRequest, type: T.Type) -> Observable<T> {
        return data(request: request).map { data -> T in
            do {
                let jsonDecoder = JSONDecoder()
                let decodedObject = try jsonDecoder.decode(type, from: data)
                return decodedObject
            } catch {
                debugPrint(error)
                throw NetworkerErrors.deserializationFailed
            }
        }
    }
}
