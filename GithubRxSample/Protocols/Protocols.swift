//
//  Protocols.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 25.12.2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import Moya

protocol Subscriber {
    func subscribe()
}

@objc protocol ViewUpdater: class {
    var tag: Int { get }
    
    func update(with: AnyHashable)
}

protocol ViewModelProtocol {
    var provider: MoyaProvider<APIClient> { get set }
    
    func updatePath(_ path: IndexPath)
    func showError(_ type: SampleError)
}
