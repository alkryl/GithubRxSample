//
//  Subscriber.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 25.12.2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import Foundation

protocol Subscriber {
    func subscribe()
}

@objc protocol ViewUpdater: class {
    var tag: Int { get }
    func update(with: AnyHashable)
}
