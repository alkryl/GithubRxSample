//
//  CommitCoordinator.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 10.02.2021.
//  Copyright © 2021 Alexander Krylov. All rights reserved.
//

import UIKit
import Swinject

class CommitCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var nav: UINavigationController
    var container: Container?
    
    //MARK: Properties
    
    var repository: String = .empty
    var childDidFinish: ((Coordinator) -> ())?
    
    //MARK: Initialization
    
    required init(navigationController: UINavigationController) {
        nav = navigationController
    }
    
    //MARK: Coordinator
    
    func start() {
        guard let vc = container?.resolve(CommitsViewController.self, argument: repository) else { return }
        
        vc.showCodeAction = showCodeAction
        vc.dismissAction = dismissAction
        
        nav.pushViewController(vc, animated: true)
    }
    
    func finish() {
        childDidFinish?(self)
    }
    
    //MARK: Private
    
    private func showCode(with name: String, and hash: String) {
        guard let codeCoordinator = container?.resolve(CodeCoordinator.self, arguments: nav, name, hash, didFinishAction) else { return }
        addChildCoordinator(codeCoordinator)
        codeCoordinator.start()
    }
}

//MARK: Computed properties

extension CommitCoordinator {
    private var showCodeAction: (String, String) -> () {
        return { [weak self] (name, hash) in
            self?.showCode(with: name, and: hash)
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
