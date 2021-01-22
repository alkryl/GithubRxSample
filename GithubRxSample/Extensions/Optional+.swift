//
//  Optional+.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 25.12.2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import Foundation
import RxSwift

extension Optional where Wrapped == String {
    var orEmpty: String {
        return self ?? .empty
    }
}

extension Optional where Wrapped == Bool {
    var orFalse: Bool {
        return self ?? false
    }
}

extension Optional where Wrapped == Data {
    var orEmpty: Data {
        return self ?? .empty
    }
}

extension Optional where Wrapped == Int {
    var orEmpty: Int {
        return self ?? .zero
    }
}

extension Optional where Wrapped == DisposeBag {
    var orDefault: DisposeBag {
        return self ?? DisposeBag()
    }
}
