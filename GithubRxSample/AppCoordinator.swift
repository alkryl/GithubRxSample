//
//  AppCoordinator.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 28.01.2021.
//  Copyright © 2021 Alexander Krylov. All rights reserved.
//

import UIKit
import Swinject

class AppCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var nav: UINavigationController
    var container: Container?
    
    //MARK: Initialization
    
    required init(navigationController: UINavigationController) {
        nav = navigationController
    }
    
    //MARK: Coordinator
    
    func start() {
        guard let mainCoordinator = container?.resolve(MainCoordinator.self, argument: nav)
            else { return }
        addChildCoordinator(mainCoordinator)
        mainCoordinator.start()
    }
    
    func finish() { }
}
