//
//  ListViewModel.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 26/05/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import RxSwift
import RxCocoa
import Moya
import Moya_ObjectMapper

final class ListViewModel {
    
    //MARK: Rx
    
    private let db = DisposeBag()
    
    private(set) var dataSections = BehaviorRelay<[RepositorySection]>(value: [])
    private(set) var selectedIndexPath = BehaviorRelay(value: IndexPath())
    private(set) var pageRelay = BehaviorRelay(value: 1)
    private(set) var errorSubject = PublishSubject<SampleError>()

    //MARK: Properties
    
    private var repositories = [Repository]()
    private var language: String = .empty
    
    var provider: MoyaProvider<APIClient> = {
        let configuration = NetworkLoggerPlugin.Configuration(logOptions: [.requestMethod])
        let plugin = NetworkLoggerPlugin(configuration: configuration)
        let provider = MoyaProvider<APIClient>(plugins: [plugin])
        return provider
    }()
    
    //MARK: Initialization
    
    init(language: String) {
        self.language = language
        subscribe()
    }
    
    //MARK: Methods
    
    func updatePage() {
        pageRelay.accept(nextPage)
    }
    
    func updatePath(_ path: IndexPath) {
        selectedIndexPath.accept(path)
    }
    
    func showError(_ type: SampleError) {
        errorSubject.onNext(type)
    }
    
    //MARK: Handlers
    
    private func didObtainRepositories(_ items: [Repository]) {
        repositories.append(contentsOf: items)
        let sections = RepositorySection(header: .empty, items: repositories)
        dataSections.accept([sections])
    }
    
    private func didObtainError(_ type: SampleError) {
        showError(type)
    }
}

//MARK: Computed properties

extension ListViewModel {
    private var nextPage: Int {
        return pageRelay.value + 1
    }
    
    var repositoryName: String {
        return repositories[selectedIndexPath.value.row].fullName.orEmpty
    }
}

//MARK: Subscriber

extension ListViewModel: Subscriber {
    func subscribe() {
        pageRelay
            .flatMap { self.provider.rx.request(.repositories(self.language, $0)) }
            .mapObject(Repositories.self)
            .catchError { [weak self] error in
                self?.didObtainError(.mapping(reason: error.localizedDescription))
                return Observable.empty()
            }
            .subscribe { [weak self] event in
                switch event {
                case .next(let repositories):
                    guard let self = self, let items = repositories.items else { return }
                    self.didObtainRepositories(items)
                case .error(let error):
                    self?.didObtainError(.obtaining(reason: error.localizedDescription))
                default: break
                }
            }
            .disposed(by: db)
    }
}
