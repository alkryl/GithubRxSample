//
//  URLSession+Rx.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 01/06/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import Foundation
import RxSwift

public enum RxURLSessionError: Error {
  case unknown
  case invalidResponse(URLResponse)
}

extension Reactive where Base == URLSession {
    
    func response(with request: URLRequest) -> Observable<(HTTPURLResponse, Data)> {
        return Observable.create { observer in
            let task = self.base.dataTask(with: request) { (data, response, error) in
                guard let response = response, let data = data else {
                    observer.on(.error(error ?? RxURLSessionError.unknown))
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse else {
                    observer.on(.error(RxURLSessionError.invalidResponse(response)))
                    return
                }
                observer.onNext((httpResponse, data))
                observer.onCompleted()
            }
            task.resume()

            return Disposables.create(with: task.cancel)
        }
    }
    
    func data(with request: URLRequest) -> Observable<Data> {
        return response(with: request).flatMap { (httpResponse, data) -> Observable<Data> in
            return 200 ..< 300 ~= httpResponse.statusCode ? Observable.just(data) : Observable.error(RxURLSessionError.unknown)
        }
    }
}
