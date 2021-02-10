//
//  Dependencies.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 28.01.2021.
//  Copyright © 2021 Alexander Krylov. All rights reserved.
//

import Swinject
import RxSwift
import RxCocoa
import Moya

class Dependencies {
    
    //MARK: Properties
    
    let container = Container()
        
    //MARK: Initialization
    
    init() {
        registerProvider()
        registerCoordinators()
        registerControllers()
    }
    
    //MARK: Private
    
    private func registerProvider() {
        container.register(Provider.self) { _ in
            return APIClient.provider
        }
    }
    
    private func registerCoordinators() {
        container.register(AppCoordinator.self) { (_, nav: UINavigationController) in
            let coordinator = AppCoordinator(navigationController: nav)
            coordinator.container = self.container
            return coordinator
        }
        
        container.register(MainCoordinator.self) { (_, nav: UINavigationController) in
            let coordinator = MainCoordinator(navigationController: nav)
            coordinator.container = self.container
            return coordinator
        }

        container.register(LanguageCoordinator.self) { (_, nav: UINavigationController, relay: BehaviorRelay<String>, didFinish: @escaping CoordinatorClosure) in
            let coordinator = LanguageCoordinator(navigationController: nav)
            coordinator.container = self.container
            coordinator.languageRelay = relay
            coordinator.childDidFinish = didFinish
            return coordinator
        }
        
        container.register(RepositoryCoordinator.self) { (_, nav: UINavigationController, language: String, didFinish: @escaping CoordinatorClosure) in
            let coordinator = RepositoryCoordinator(navigationController: nav)
            coordinator.container = self.container
            coordinator.language = language
            coordinator.childDidFinish = didFinish
            return coordinator
        }
        
        container.register(CommitCoordinator.self) { (_, nav: UINavigationController, repository: String, didFinish: @escaping CoordinatorClosure) in
            let coordinator = CommitCoordinator(navigationController: nav)
            coordinator.container = self.container
            coordinator.repository = repository
            coordinator.childDidFinish = didFinish
            return coordinator
        }
        
        container.register(CodeCoordinator.self) { (_, nav: UINavigationController, repository: String, hash: String, didFinish: @escaping CoordinatorClosure) in
            let coordinator = CodeCoordinator(navigationController: nav)
            coordinator.container = self.container
            coordinator.repository = repository
            coordinator.hash = hash
            coordinator.childDidFinish = didFinish
            return coordinator
        }
    }
    
    private func registerControllers() {
        let mainStoryboard = {
            R.storyboard.main().instantiateViewController(identifier: $0)
        }
        
        container.register(MainViewController.self) { _ in
            let vc = mainStoryboard(MainViewController.identifier) as! MainViewController
            vc.viewModel = MainViewModel()
            return vc
        }.inObjectScope(.container)
        
        container.register(LanguageViewController.self) { (_, relay: BehaviorRelay<String>) in
            let vc = mainStoryboard(LanguageViewController.identifier) as! LanguageViewController
            vc.viewModel = LanguageViewModel(language: relay)
            return vc
        }.inObjectScope(.container)
        
        container.register(ListViewController.self) { (r, language: String) in
            let vc = mainStoryboard(ListViewController.identifier) as! ListViewController
            let provider = r.resolve(Provider.self)!
            vc.viewModel = ListViewModel(language: language, provider: provider)
            return vc
        }
        
        container.register(CommitsViewController.self) { (r, name: String) in
            let vc = mainStoryboard(CommitsViewController.identifier) as! CommitsViewController
            let provider = r.resolve(Provider.self)!
            vc.viewModel = CommitsViewModel(repository: name, provider: provider)
            return vc
        }
        
        container.register(CodeViewController.self) { (r, name: String, hash: String) in
            let vc = mainStoryboard(CodeViewController.identifier) as! CodeViewController
            let provider = r.resolve(Provider.self)!
            vc.viewModel = CodeViewModel(name: name, hash: hash, provider: provider)
            return vc
        }
    }
}
