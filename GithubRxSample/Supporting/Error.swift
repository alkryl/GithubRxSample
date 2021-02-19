//
//  Error.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 22.01.2021.
//  Copyright © 2021 Alexander Krylov. All rights reserved.
//

import Foundation

enum SampleError: Error {
    case obtaining(reason: String)
    case mapping(reason: String)
    case dequeue(reason: String)
}
