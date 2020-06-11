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

struct CodeViewModel {
    
    private let repoName: String
    private let hash: String
    
    var title: Driver<String> {
        return Observable.just(hash).asDriver(onErrorJustReturn: "")
    }
    var request: Observable<URLRequest> {
        return APIService.API.commitRequest(repo: repoName, hash: hash)
    }
    
    //MARK: Initialization
    
    init(name: String, hash: String) {
        self.repoName = name
        self.hash = hash
    }
}
