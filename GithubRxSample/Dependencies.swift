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

class Dependencies {
    
    //MARK: Properties
    
    let container = Container()
        
    //MARK: Initialization
    
    init() {
        registerCoordinators()
        registerControllers()
    }
    
    //MARK: Private
    
    private func registerCoordinators() {
        container.register(MainCoordinator.self) { (_, nav: UINavigationController) in
            let coordinator = MainCoordinator()
            coordinator.navigationController = nav
            coordinator.container = self.container
            return coordinator
        }
    }
    
    private func registerControllers() {
        let mainStoryboard = {
            R.storyboard.main().instantiateViewController(identifier: $0)
        }
        
        container.register(MainViewController.self) { (_, coordinator: MainCoordinator) in
            let vc = mainStoryboard(MainViewController.identifier) as! MainViewController
            vc.coordinator = coordinator
            vc.viewModel = MainViewModel()
            return vc
        }.inObjectScope(.container)
        
        container.register(LanguageViewController.self) { (_, coordinator: MainCoordinator, relay: BehaviorRelay<String>) in
            let vc = mainStoryboard(LanguageViewController.identifier) as! LanguageViewController
            vc.coordinator = coordinator
            vc.viewModel = LanguageViewModel(language: relay)
            return vc
        }
        
        container.register(ListViewController.self) { (_, coordinator: MainCoordinator, language: String) in
            let vc = mainStoryboard(ListViewController.identifier) as! ListViewController
            vc.coordinator = coordinator
            vc.viewModel = ListViewModel(language: language)
            return vc
        }
        
        container.register(CommitsViewController.self) { (_, coordinator: MainCoordinator, name: String) in
            let vc = mainStoryboard(CommitsViewController.identifier) as! CommitsViewController
            vc.coordinator = coordinator
            vc.viewModel = CommitsViewModel(repository: name)
            return vc
        }
        
        container.register(CodeViewController.self) { (_, coordinator: MainCoordinator, name: String, hash: String) in
            let vc = mainStoryboard(CodeViewController.identifier) as! CodeViewController
            vc.viewModel = CodeViewModel(name: name, hash: hash)
            return vc
        }
    }
}
