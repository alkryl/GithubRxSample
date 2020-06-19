//
//  RepoCellViewModel.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 19/06/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import Foundation

struct RepoCellViewModel {
    
    var repo: Repository!
    
    //MARK: Initialization
    
    init(_ repo: Repository) {
        self.repo = repo
    }
}
