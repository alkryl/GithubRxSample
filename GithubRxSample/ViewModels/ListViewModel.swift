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
import Moya

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
        let configuration = NetworkLoggerPlugin.Configuration(logOptions: [.requestMethod, .successResponseBody])
        let plugin = NetworkLoggerPlugin(configuration: configuration)
        let provider = MoyaProvider<APIClient>(plugins: [plugin])
        
//        page.asObservable()
////            .flatMap { APIService().getData(.repositories(language, $0)) }
//            .flatMap {
//                provider.request(.repositories(lang: <#T##String#>, page: <#T##Int#>), completion: <#T##Completion##Completion##(Result<Response, MoyaError>) -> Void#>)
//
//
//            }
//            .flatMap { ($0.deserialize() as Observable<Repositories>) }
//            .map { $0.items }
//            .asDriver(onErrorJustReturn: [])
//            .drive(onNext: { [unowned self] in
//                self.data.accept(self.data.value + $0)
//            }).disposed(by: db)

        page.asObservable()
            .flatMap { provider.rx.request(.repositories(language, page: $0)) }
            .subscribe { response in
                switch response {
                case .next(let response):
                    print(response)
                case .error(let error):
                    break
                default: break
                }
            }
//            .subscribe { event in
//                switch event {
//                case .success(let response):
//                    // do something with the data
//                break
//                case .error(let error):
//                    // handle the error
//                break
//                }
//            }
            .disposed(by: db)
        
    }
    
    private func getRepositories(with page: Int) {
        
    }
    
    //MARK: Methods
    
    func updatePage() {
        page.accept(page.value + 1)
    }
    
    func updatePath(_ path: IndexPath) {
        selectedIndexPath.accept(path)
    }
}
