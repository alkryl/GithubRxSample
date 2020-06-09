//
//  AuthorLoginLabel.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 08/06/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AuthorLoginLabel: UILabel {

    var login: BehaviorRelay<String?> = BehaviorRelay(value: "")
    private let db = DisposeBag()

    //MARK: Initialization

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        bindUI()
    }
    
    //MARK: Methods
    
    private func bindUI() {
        login.asDriver()
            .unwrap()
            .drive(self.rx.text)
            .disposed(by: db)
    }
}
