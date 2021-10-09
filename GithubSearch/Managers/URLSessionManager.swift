//
//  URLSessionManager.swift
//  GithubSearch
//
//  Created by Eido Goya on 2021/10/04.
//

import Foundation
import RxSwift

protocol URLSessionManagerManagerProtocol {
    func request<T: Codable>(request: URLRequest, type: T.Type) -> PrimitiveSequence<SingleTrait, T>
}

final class URLSessionManager: URLSessionManagerManagerProtocol {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T>(request: URLRequest, type: T.Type) -> Single<T> where T: Codable {
        return Single.create { observer -> Disposable in
            
            let dataTask = URLSession(configuration: .default)
                .dataTask(with: request) { data, response, error in
                    if let data = data,
                       let response = response as? HTTPURLResponse {
                        if response.statusCode == 200 {
                            do {
                                let decodedData = try JSONDecoder().decode(type, from: data)
                                observer(.success(decodedData))
                            } catch let error {
                                observer(.failure(error))
                            }
                        } else {
                            let jsonValue = try? JSONSerialization.jsonObject(with: data,
                                                                              options: .allowFragments)
                            let error = NSError(domain: "",
                                                code: response.statusCode,
                                                userInfo:
                                                    [NSLocalizedDescriptionKey:
                                                        String(describing: jsonValue)]) as Error
                            observer(.failure(error))
                        }
                    }
                }
            
            dataTask.resume()
            return Disposables.create {
                dataTask.cancel()
            }
        }
    }
    
    func request<T>(url: URL, type: T.Type) -> Single<T> where T: Codable {
        
        return Single.create { single -> Disposable in
            
            let dataTask = self.session.dataTask(with: url) { data, response, error in
                if let data = data,
                   let response = response as? HTTPURLResponse {
                    if response.statusCode == 200 {
                        do {
                            let decodedData = try JSONDecoder().decode(type, from: data)
                            single(.success(decodedData))
                        } catch let error {
                            single(.failure(error))
                        }
                    } else {
                        let jsonValue = try? JSONSerialization.jsonObject(with: data,
                                                                          options: .allowFragments)
                        let error = NSError(domain: "",
                                            code: response.statusCode,
                                            userInfo:
                                                [NSLocalizedDescriptionKey:
                                                    String(describing: jsonValue)]) as Error
                        single(.failure(error))
                    }
                }
            }
            
            dataTask.resume()
            return Disposables.create {
                dataTask.cancel()
            }
        }
    }
}
