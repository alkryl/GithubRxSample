//
//  CommitsViewModel.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 26/05/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import RxSwift
import RxCocoa
import Moya
import Moya_ObjectMapper

final class CommitsViewModel: ViewModelProtocol {
    
    //MARK: Rx
    
    private let db = DisposeBag()
    
    private(set) var dataSections = BehaviorRelay<[CommitSection]>(value: [])
    private(set) var selectedIndexPath = PublishSubject<IndexPath>()
    private(set) var hashSubject = PublishSubject<String>()
    private(set) var errorSubject = PublishSubject<SampleError>()
    
    //MARK: Properties
    
    private var commits = [CommitItem]()
    private(set) var repository: String
        
    var provider: MoyaProvider<APIClient> = {
        let configuration = NetworkLoggerPlugin.Configuration(logOptions: [.requestMethod])
        let plugin = NetworkLoggerPlugin(configuration: configuration)
        let provider = MoyaProvider<APIClient>(plugins: [plugin])
        return provider
    }()
        
    //MARK: Initialization
    
    init(repository: String) {
        self.repository = repository
        subscribe()
    }
    
    //MARK: Methods
    
    func updatePath(_ path: IndexPath) {
        selectedIndexPath.onNext(path)
    }
    
    func showError(_ type: SampleError) {
        errorSubject.onNext(type)
    }
    
    //MARK: Handlers
    
    private func didObtainCommits(_ items: [CommitItem]) {
        commits.append(contentsOf: items)
        let sections = CommitSection(header: .empty, items: commits)
        dataSections.accept([sections])
    }
    
    private func didObtainError(_ type: SampleError) {
        showError(type)
    }
}

//MARK: Computed properties

extension CommitsViewModel {
    var title: Driver<String> {
        return Driver.just(repository)
            .map { $0.components(separatedBy: "/").last }
            .unwrap()
    }
}

//MARK: Subscriber

extension CommitsViewModel: Subscriber {
    func subscribe() {
        Observable<String>.just(.empty)
            .flatMap { _ in self.provider.rx.request(.commits(self.repository)) }
            .mapArray(CommitItem.self)
            .catchError { [weak self] error in
                self?.didObtainError(.mapping(reason: error.localizedDescription))
                return Observable.empty()
            }
            .subscribe { [weak self] event in
                switch event {
                case .next(let commits):
                    guard let self = self else { return }
                    self.didObtainCommits(commits)
                case .error(let error):
                    self?.didObtainError(.obtaining(reason: error.localizedDescription))
                default: break
                }
            }
            .disposed(by: db)
        
        selectedIndexPath
            .map { $0.row }
            .subscribe(onNext: { [weak self] row in
                let hash = (self?.commits[row].hash).orEmpty
                self?.hashSubject.onNext(hash)
            })
            .disposed(by: db)
    }
}
