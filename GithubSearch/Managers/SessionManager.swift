//
//  SessionManager+Alamofire.swift
//  GithubSearch
//
//  Created by Eido Goya on 2021/10/04.
//

import Alamofire

protocol SessionManagerProtocol {
    
    func request(_ convertible: URLConvertible,
                 method: HTTPMethod,
                 parameters: Parameters?,
                 encoding: ParameterEncoding,
                 headers: HTTPHeaders?,
                 interceptor: RequestInterceptor?,
                 requestModifier: Session.RequestModifier?) -> DataRequest
}

extension Session: SessionManagerProtocol {
    
    
}
