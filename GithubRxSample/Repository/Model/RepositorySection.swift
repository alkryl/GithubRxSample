//
//  RepositorySection.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 25.12.2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import RxDataSources

struct RepositorySection {
    var header: String
    var items: [Item]
}

extension RepositorySection: SectionModelType {
    typealias Item = Repository
    
    init(original: RepositorySection, items: [Item]) {
        self = original
        self.items = items
    }
}
