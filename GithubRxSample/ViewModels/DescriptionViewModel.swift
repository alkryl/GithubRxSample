//
//  DescriptionViewModel.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 26/05/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class DescriptionViewModel {
    
    private let db = DisposeBag()
    private var data = BehaviorRelay(value: [Item]())
    
    var selectedIndexPath = PublishSubject<IndexPath>()
    var hash = PublishSubject<String>()
    var repoName: String
        
    var tableData: Driver<[Item]> {
        return data.skipWhile { $0.isEmpty }.share().asDriver(onErrorJustReturn: [])
    }
    var title: Driver<String> {
        return Observable.just(repoName).map { $0.components(separatedBy: "/").last }
            .unwrap().asDriver(onErrorJustReturn: "")
    }
        
    //MARK: Initialization
    
    init(repository: String) {
        self.repoName = repository
        
        APIService().getData(.commits(repository))
            .flatMap { $0.deserialize() as Observable<[Item]> }
            .asDriver(onErrorJustReturn: [])
            .drive(onNext: { [unowned self] in
                self.data.accept(self.data.value + $0)
            }).disposed(by: db)
        
        selectedIndexPath.asObservable()
            .map { $0.row }
            .subscribe(onNext: { row in
                self.hash.onNext(self.data.value[row].hash)
            }).disposed(by: db)
    }
}
