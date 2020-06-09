//
//  LanguageViewModel.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 26/05/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class LanguageViewModel {
    
    private let db = DisposeBag()
    private let model = Languages()
    
    let languages: Observable<[String]>
    var selectedRow = PublishSubject<Int>()
    private let selectedLanguage: BehaviorRelay<String>
    
    //MARK: Initialization
    
    init(language: BehaviorRelay<String>) {
        self.selectedLanguage = language
        
        languages = Observable.from(optional: model.languages)
        
        selectedRow.asObservable()
            .subscribe(onNext: { [unowned self] row in
                self.selectedLanguage.accept(self.model.languages[row])
            }).disposed(by: db)
    }
}
