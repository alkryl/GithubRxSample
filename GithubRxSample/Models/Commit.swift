//
//  Commit.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 05/06/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import Foundation

struct Item: Codable {
    let hash: String
    let commit: Commit
    let author: Author?
}

struct Commit: Codable {
    let message: String
    let author: AuthorInfo
}

struct Author: Codable {
    let login: String
    let avatar: String?
}

struct AuthorInfo: Codable {
    let date: String
}

private extension Item {
    enum CodingKeys: String, CodingKey {
        case hash = "sha"
        case commit, author
    }
}

private extension Author {
    enum CodingKeys: String, CodingKey {
        case login
        case avatar = "avatar_url"
    }
}
