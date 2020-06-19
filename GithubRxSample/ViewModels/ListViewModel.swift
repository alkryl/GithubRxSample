//
//  ListViewModel.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 26/05/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ListViewModel {
    
    private let db = DisposeBag()
    private var data = BehaviorRelay(value: [Repository]())
    private var page = BehaviorRelay(value: 1)
    
    var selectedIndexPath = BehaviorRelay(value: IndexPath())
    
    var tableData: Driver<[Repository]> {
        return data.skipWhile { $0.isEmpty }.share().asDriver(onErrorJustReturn: [])
    }
    var repoName: String {
        return data.value[selectedIndexPath.value.row].fullName
    }
    
    //MARK: Initialization
    
    init(language: String) {
        page.asObservable()
            .flatMap { APIService().getData(.repositories(language, $0)) }
            .flatMap { ($0.deserialize() as Observable<Repositories>) }
            .map { $0.items }
            .asDriver(onErrorJustReturn: [])
            .drive(onNext: { [unowned self] in
                self.data.accept(self.data.value + $0)
            }).disposed(by: db)
    }
    
    //MARK: Methods
    
    func updatePage() {
        page.accept(page.value + 1)
    }
    
    func updatePath(_ path: IndexPath) {
        selectedIndexPath.accept(path)
    }
}
