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

protocol CellViewModelProtocol {
    func parameter(for tag: Int) -> AnyHashable?
}
