//
//  StarsLabel.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 03/06/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class StarsLabel: UILabel {

    var stars = BehaviorRelay(value: 0)
    private let db = DisposeBag()

    //MARK: Initialization

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        bindUI()
    }
    
    //MARK: Methods
    
    private func bindUI() {
        stars.asDriver()
            .map { "\($0) ⭐︎"}
            .drive(self.rx.text)
            .disposed(by: db)
    }
}
