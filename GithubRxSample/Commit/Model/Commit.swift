//
//  Commit.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 05/06/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import ObjectMapper

struct CommitItem: Mappable {
    var hash: String?
    var commit: Commit?
    var author: Author?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        hash   <- map["sha"]
        commit <- map["commit"]
        author <- map["author"]
    }
}

extension CommitItem {
    struct Commit: Mappable {
        var message: String?
        var author: AuthorInfo?
        
        init?(map: Map) { }
        
        mutating func mapping(map: Map) {
            message <- map["message"]
            author  <- map["author"]
        }
    }

    struct Author: Mappable {
        var login: String?
        var avatar: String?
        
        init?(map: Map) { }
        
        mutating func mapping(map: Map) {
            login  <- map["login"]
            avatar <- map["avatar_url"]
        }
    }

    struct AuthorInfo: Mappable {
        var date: String?
        
        init?(map: Map) { }
        
        mutating func mapping(map: Map) {
            date <- map["date"]
        }
    }
}
