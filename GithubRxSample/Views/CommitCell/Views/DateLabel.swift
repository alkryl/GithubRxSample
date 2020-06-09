//
//  DateLabel.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 08/06/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DateLabel: UILabel {

    var date: BehaviorRelay<String> = BehaviorRelay(value: "")
    private let db = DisposeBag()

    //MARK: Initialization

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        bindUI()
    }
    
    //MARK: Methods
    
    private func bindUI() {
        date.asDriver()
            .map { str -> Date? in
                let getFormatter = DateFormatter()
                getFormatter.dateFormat = "yyyy-MM-dd"
                return getFormatter.date(from: String(str.prefix(10)))
            }
            .unwrap()
            .map { date -> String in
                let outFormatter = DateFormatter()
                outFormatter.dateFormat = "dd MMM yyyy"
                return outFormatter.string(from: date)
            }
            .map { "committed on " + $0 }
            .drive(self.rx.text)
            .disposed(by: db)
    }
}
