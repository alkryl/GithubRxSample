//
//  Repository.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 30/05/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import Foundation

struct Repositories: Codable {
    let items: [Repository]
}

struct Repository: Codable {
    let name, fullName: String
    let `private`: Bool
    let description: String?
    let owner: Owner
    let stars: Int
    let language: String
}

struct Owner: Codable {
    let login: String
    let avatar: String
}

private extension Repository {
    enum CodingKeys: String, CodingKey {
        case name, `private`, description, owner, language
        case fullName = "full_name"
        case stars = "stargazers_count"
    }
}

private extension Owner {
    enum CodingKeys: String, CodingKey {
        case login
        case avatar = "avatar_url"
    }
}
