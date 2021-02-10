//
//  RepositoryCoordinator.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 04.02.2021.
//  Copyright © 2021 Alexander Krylov. All rights reserved.
//

import UIKit
import Swinject

class RepositoryCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var nav: UINavigationController
    var container: Container?
    
    //MARK: Properties
    
    var language: String = .empty
    var childDidFinish: ((Coordinator) -> ())?
    
    //MARK: Initialization
    
    required init(navigationController: UINavigationController) {
        nav = navigationController
    }
    
    //MARK: Coordinator
    
    func start() {
        guard let vc = container?.resolve(ListViewController.self, argument: language) else { return }
        
        vc.showCommitsAction = showCommitsAction
        vc.dismissAction = dismissAction
        
        nav.pushViewController(vc, animated: true)
    }
    
    func finish() {
        childDidFinish?(self)
    }
    
    //MARK: Private
    
    func showCommits(for repository: String) {
        guard let commitCoordinator = container?.resolve(CommitCoordinator.self, arguments: nav, repository, didFinishAction) else { return }
        addChildCoordinator(commitCoordinator)
        commitCoordinator.start()
    }
}

//MARK: Computed properties

extension RepositoryCoordinator {
    private var showCommitsAction: (String) -> () {
        return { [weak self] repository in
            self?.showCommits(for: repository)
        }
    }
    private var dismissAction: EmptyClosure {
        return { [weak self] in
            self?.finish()
        }
    }
    private var didFinishAction: (Coordinator) -> () {
        return { [weak self] coordinator in
            self?.childDidFinish(coordinator)
        }
    }
}
