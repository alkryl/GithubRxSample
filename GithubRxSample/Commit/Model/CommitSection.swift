//
//  CommitSection.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 25.01.2021.
//  Copyright © 2021 Alexander Krylov. All rights reserved.
//

import RxDataSources

struct CommitSection {
    var header: String
    var items: [CommitItem]
}

extension CommitSection: SectionModelType {
    typealias Item = CommitItem
    
    init(original: CommitSection, items: [Item]) {
        self = original
        self.items = items
    }
}
