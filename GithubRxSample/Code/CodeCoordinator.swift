//
//  CodeCoordinator.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 10.02.2021.
//  Copyright © 2021 Alexander Krylov. All rights reserved.
//

import UIKit
import Swinject

class CodeCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var nav: UINavigationController
    var container: Container?
    
    //MARK: Properties
    
    var repository: String = .empty
    var hash: String = .empty
    var childDidFinish: ((Coordinator) -> ())?
    
    //MARK: Initialization
    
    required init(navigationController: UINavigationController) {
        nav = navigationController
    }
    
    //MARK: Coordinator
    
    func start() {
        guard let vc = container?.resolve(CodeViewController.self, arguments: repository, hash) else { return }

        vc.dismissAction = dismissAction

        nav.pushViewController(vc, animated: true)
    }
    
    func finish() {
        childDidFinish?(self)
    }
}

//MARK: Computed properties

extension CodeCoordinator {
    private var dismissAction: EmptyClosure {
        return { [weak self] in
            self?.finish()
        }
    }
}
