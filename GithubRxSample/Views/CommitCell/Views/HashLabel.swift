//
//  HashLabel.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 08/06/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HashLabel: UILabel {

    var commitHash: BehaviorRelay<String> = BehaviorRelay(value: "")
    private let db = DisposeBag()

    //MARK: Initialization

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        bindUI()
    }
    
    //MARK: Methods
    
    private func bindUI() {
        commitHash.asDriver()
            .map { String($0.prefix(5)) }
            .drive(self.rx.text)
            .disposed(by: db)
    }
}
