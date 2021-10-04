//
//  BundleManager.swift
//  GithubSearch
//
//  Created by Eido Goya on 2021/10/04.
//

import Foundation
import RxSwift

protocol BundleManagerProtocol {
    func fetchJson<T: Codable>(fileName: String, type: T.Type) -> PrimitiveSequence<SingleTrait, T>
}

final class BundleManager: BundleManagerProtocol {
    
    func fetchJson<T>(fileName: String, type: T.Type) -> Single<T> where T: Codable {
        return Single.create { observer -> Disposable in
            guard let jsonURL = Bundle.main.url(forResource: fileName,
                                                withExtension: "json"),
                  let jsonData = try? Data(contentsOf: jsonURL) else {
                      fatalError()
                  }
            do {
                let decodedData = try JSONDecoder().decode(type.self,
                                                           from: jsonData)
                observer(.success(decodedData))
            } catch let error as NSError {
                observer(.failure(error))
            }
            return Disposables.create { }
        }
    }
}
