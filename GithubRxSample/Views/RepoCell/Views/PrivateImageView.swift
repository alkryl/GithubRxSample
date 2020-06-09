//
//  PrivateImageView.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 03/06/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PrivateImageView: UIImageView {

    var isPrivate = BehaviorRelay(value: false)
    private let db = DisposeBag()

    //MARK: Initialization

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        bindUI()
    }
    
    //MARK: Methods
    
    private func bindUI() {
        isPrivate.asDriver()
            .map { value -> UIImage? in
                return UIImage(named: value ? "private.png" : "free.png")
            }
            .drive(self.rx.image)
            .disposed(by: db)
    }
}
