//
//  URLSessionManager2.swift
//  GithubSearch
//
//  Created by Eido Goya on 2021/10/09.
//

import Foundation

protocol URLSessionProtocol {
//    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask

    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
//    func uploadTask(with request: URLRequest, fromFile fileURL: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionUploadTask
//    func uploadTask(with request: URLRequest, from bodyData: Data?, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionUploadTask
//    func downloadTask(with request: URLRequest, completionHandler: @escaping (URL?, URLResponse?, Error?) -> Void) -> URLSessionDownloadTask
//    func downloadTask(with url: URL, completionHandler: @escaping (URL?, URLResponse?, Error?) -> Void) -> URLSessionDownloadTask
//    func downloadTask(withResumeData resumeData: Data, completionHandler: @escaping (URL?, URLResponse?, Error?) -> Void) -> URLSessionDownloadTask
}

extension URLSession: URLSessionProtocol {
}

class URLSessionDataTaskMcok: URLSessionDataTask {
    private let closure: () -> Void
    
    @available(*, deprecated)
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    override func resume() {
        closure()
    }
}

class URLSessionMock: URLSessionProtocol {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    
    var url: URL?
    var data: Data?
    var error: Error?
    
    @available(*, deprecated)
    func dataTask(with url: URL,
                  completionHandler: @escaping CompletionHandler
    ) -> URLSessionDataTask {
        self.url = url
        let data = self.data
        let error = self.error
        
        return URLSessionDataTaskMcok {
            completionHandler(data, nil, error)
        }
    }
    
}
