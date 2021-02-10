//
//  CodeViewModel.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 11/06/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

struct CodeViewModel {
    
    //MARK: Properties
    
    private var provider: Provider?
    private let name: String
    private let hash: String
    
    //MARK: Initialization
    
    init(name: String, hash: String, provider: Provider) {
        self.name = name
        self.hash = hash
        self.provider = provider
    }
}

//MARK: Computed properties

extension CodeViewModel {
    var title: Driver<String> {
        return Driver.just(String(hash.prefix(10)))
    }
    
    var request: Observable<URLRequest> {
        guard let provider = provider else { return Observable.empty() }
        
        return provider.rx
                .request(.commitInfo(repository: name, hash: hash))
                .asObservable()
                .compactMap { $0.request?.url?.absoluteString }
                .map { $0.replacingOccurrences(of: "api.", with: String.empty) }
                .compactMap { URL(string: $0) }
                .map { URLRequest(url: $0) }
    }
}
