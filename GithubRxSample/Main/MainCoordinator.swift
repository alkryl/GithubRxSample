//
//  MainCoordinator.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 04.02.2021.
//  Copyright © 2021 Alexander Krylov. All rights reserved.
//

import Foundation
import Swinject
import RxSwift
import RxCocoa

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var nav: UINavigationController
    var container: Container?
    
    //MARK: Initialization
    
    required init(navigationController: UINavigationController) {
        nav = navigationController
    }
    
    //MARK: Coordinator
    
    func start() {
        guard let vc = container?.resolve(MainViewController.self) else { return }
        
        vc.showLanguagesAction = showLanguagesAction
        vc.showRepositoriesAction = showRepositoriesAction
                
        nav.pushViewController(vc, animated: false)
    }
    
    func finish() {
        removeAllChildCoordinators()
    }
    
    //MARK: Private
    
    private func showLanguages(with relay: BehaviorRelay<String>) {
        guard let languageCoordinator = container?.resolve(LanguageCoordinator.self, arguments: nav, relay, didFinishAction) else { return }
        addChildCoordinator(languageCoordinator)
        languageCoordinator.start()
    }
    
    private func showRepositories(for language: String) {
        guard let repositoryCoordinator = container?.resolve(RepositoryCoordinator.self, arguments: nav, language, didFinishAction) else { return }
        addChildCoordinator(repositoryCoordinator)
        repositoryCoordinator.start()
    }
}

//MARK: Computed properties

extension MainCoordinator {
    private var showLanguagesAction: (BehaviorRelay<String>) -> () {
        return { [weak self] relay in
            self?.showLanguages(with: relay)
        }
    }
    private var showRepositoriesAction: (String) -> () {
        return { [weak self] language in
            self?.showRepositories(for: language)
        }
    }
    private var didFinishAction: (Coordinator) -> () {
        return { [weak self] coordinator in
            self?.childDidFinish(coordinator)
        }
    }
}
