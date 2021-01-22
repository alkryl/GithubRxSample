//
//  Repository.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 30/05/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import ObjectMapper

struct Repositories: Mappable {
    var items: [Repository]?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        items <- map["items"]
    }
}

struct Repository: Mappable {
    var name, fullName: String?
    var access: Bool?
    var description: String?
    var owner: Owner?
    var stars: Int?
    var language: String?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        name        <- map["name"]
        fullName    <- map["full_name"]
        access      <- map["private"]
        description <- map["description"]
        owner       <- map["owner"]
        stars       <- map["stargazers_count"]
        language    <- map["language"]
    }
}

extension Repository {
    struct Owner: Mappable {
        var login: String?
        var avatar: String?
        
        init?(map: Map) { }
        
        mutating func mapping(map: Map) {
            login  <- map["login"]
            avatar <- map["avatar_url"]
        }
    }
}
