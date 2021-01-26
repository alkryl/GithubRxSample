//
//  CommitCellViewModel.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 19/06/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

struct CommitCellViewModel {
    
    private var commit: CommitItem
    
    //MARK: Initialization
    
    init(_ commit: CommitItem) {
        self.commit = commit
    }
}

//MARK: Computed properties

extension CommitCellViewModel {
    private var message: String {
        return (commit.commit?.message).orEmpty
    }
    
    private var avatar: String {
        return (commit.author?.avatar).orEmpty
    }
    
    private var login: String {
        return (commit.author?.login).orEmpty
    }
    
    private var date: String {
        return (commit.commit?.author?.date).orEmpty
    }
    
    private var hash: String {
        return (commit.hash).orEmpty
    }
}

//MARK: CellViewModelProtocol

extension CommitCellViewModel: CellViewModelProtocol {
    private enum Tag: Int {
        case message = 0, avatar, login, date, hash
    }
    
    func parameter(for tag: Int) -> AnyHashable? {
        switch Tag(rawValue: tag) {
        case .message: return message
        case .avatar:  return avatar
        case .login:   return login
        case .date:    return date
        case .hash:    return hash
        default:       return nil
        }
    }
}
