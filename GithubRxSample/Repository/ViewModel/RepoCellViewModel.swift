//
//  RepoCellViewModel.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 19/06/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

struct RepoCellViewModel {
    
    private var repository: Repository!
    
    //MARK: Initialization
    
    init(_ repository: Repository) {
        self.repository = repository
    }
}

//MARK: Computed properties

extension RepoCellViewModel {
    private var name: String {
        return repository.name.orEmpty
    }
    
    private var description: String {
        return repository.description.orEmpty
    }
    
    private var avatar: String {
        return (repository.owner?.avatar).orEmpty
    }
    
    private var access: Bool {
        return repository.access.orFalse
    }
    
    private var login: String {
        return (repository.owner?.login).orEmpty
    }
    
    private var language: String {
        return repository.language.orEmpty
    }
    
    private var stars: Int {
        return repository.stars.orEmpty
    }
}

//MARK: Methods

extension RepoCellViewModel {
    private enum Tag: Int {
        case avatar = 0, name, description, login, stars, access, language
    }
    
    func parameter(for tag: Int) -> AnyHashable? {
        switch Tag(rawValue: tag) {
        case .avatar:      return avatar
        case .name:        return name
        case .description: return description
        case .login:       return login
        case .stars:       return stars
        case .access:      return access
        case .language:    return language
        default:           return nil
        }
    }
}
