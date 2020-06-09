//
//  APIService.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 27/05/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxSwiftExt

class APIService {

    //MARK: Methods
    
    func getData(_ type: APIType) -> Observable<Data> {
        let target: Observable<String>!
        
        switch type {
            case .repositories(let lang, let page): target = API.repositories(lang, page: page)
            case .commits(let repo): target = API.commits(repo)
            case .image(let source): target = API.image(source)
        }
        return target
            .map { URL(string: $0) }
            .unwrap()
            .map { URLRequest(url: $0) }
            .flatMap { URLSession.shared.rx.data(with: $0) }
            .retry(2)
    }
}

extension APIService {
    enum APIType {
        case repositories(String, Int)
        case commits(String)
        case image(String)
    }
    
    private struct API {
        fileprivate static func repositories(_ language: String, page: Int) -> Observable<String> {
            return Observable.just("https://api.github.com/search/repositories?" +
                                   "q=language:\(language)" +
                                   "&sort=stars&order=desc" +
                                   "&page=\(page)" +
                                   "&per_page=20")
        }
        
        fileprivate static func commits(_ repo: String) -> Observable<String> {
            return Observable.just("https://api.github.com/repos/\(repo)/commits")
        }
        
        fileprivate static func image(_ source: String) -> Observable<String> {
            return Observable.just(source)
        }
    }
}
