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
    
    private let name: String
    private let hash: String
    
    var provider: MoyaProvider<APIClient> = {
        let configuration = NetworkLoggerPlugin.Configuration(logOptions: [.requestMethod])
        let plugin = NetworkLoggerPlugin(configuration: configuration)
        let provider = MoyaProvider<APIClient>(plugins: [plugin])
        return provider
    }()
    
    //MARK: Initialization
    
    init(name: String, hash: String) {
        self.name = name
        self.hash = hash
    }
}

//MARK: Computed properties

extension CodeViewModel {
    var title: Driver<String> {
        return Driver.just(String(hash.prefix(10)))
    }
    
    var request: Observable<URLRequest> {
        provider.rx
            .request(.commitInfo(repository: name, hash: hash))
            .asObservable()
            .compactMap { $0.request?.url?.absoluteString }
            .map { $0.replacingOccurrences(of: "api.", with: String.empty) }
            .compactMap { URL(string: $0) }
            .map { URLRequest(url: $0) }
    }
}
