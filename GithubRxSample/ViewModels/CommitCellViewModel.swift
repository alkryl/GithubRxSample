//
//  CommitCellViewModel.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 19/06/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import Foundation

struct CommitCellViewModel {
    
    var commit: Item!
    
    //MARK: Initialization
    
    init(_ commit: Item) {
        self.commit = commit
    }
}
