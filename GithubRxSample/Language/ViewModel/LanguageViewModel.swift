//
//  LanguageViewModel.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 26/05/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import RxSwift
import RxCocoa

struct LanguageViewModel: Subscriber {
    
    //MARK: Rx
    
    private let db = DisposeBag()
    
    private let selectedLanguage: BehaviorRelay<String>
    private(set) var languages: Observable<[String]>
    
    var selectedRow = PublishSubject<Int>()
    
    //MARK: Properties
    
    private let model = Language()
    
    //MARK: Initialization
    
    init(language: BehaviorRelay<String>) {
        selectedLanguage = language
        languages = Observable.from(optional: model.languages)
        subscribe()
    }
    
    //MARK: Subscriber
    
    func subscribe() {
        selectedRow
            .subscribe(onNext: {
                selectedLanguage.accept(model.languages[$0])
            }).disposed(by: db)
    }
}
