//
//  Data+Content.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 01/06/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import Foundation
import RxSwift

extension Data {
    func deserialize<T: Decodable>() -> Observable<T> {
        do {
            let array = try JSONDecoder().decode(T.self, from: self)
            return Observable.from(optional: array)
        } catch(let error) {
            return Observable.create { (observer) -> Disposable in
                observer.onError(error)
                return Disposables.create()
            }
        }
    }
}
