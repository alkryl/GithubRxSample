//
//  Language.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 27/05/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import Foundation

struct Languages {
    private let languagesArray: Array<LanguagesEnum> = [.swift, .objectiveC, .assembly,
                                                        .javaScript, .python, .java,
                                                        .html, .c]
    var languages: [String] {
        return languagesArray.map { $0.rawValue }
    }
}

extension Languages {
    enum LanguagesEnum: String {
        case swift      = "Swift"
        case objectiveC = "Objective-C"
        case assembly   = "Assembly"
        case javaScript = "JavaScript"
        case python     = "Python"
        case java       = "Java"
        case html       = "HTML"
        case c          = "C"
        case other      = "Other"
    }
}
