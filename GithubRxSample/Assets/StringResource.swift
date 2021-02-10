//
//  StringResource.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 25.12.2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

typealias EmptyClosure = (() -> ())

struct Text {
    static let repositories = "repositories"
    static let error = "Error"
    static let dequeueError = "Failed to dequeue cell"
    static let showGithub = "Show on Github?"
    static let commit = "commited on "
}

struct File {
    enum Extension {
        static let json = "json"
    }
}
