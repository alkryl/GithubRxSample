//
//  Coordinator.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 28.01.2021.
//  Copyright © 2021 Alexander Krylov. All rights reserved.
//

import UIKit
import Swinject

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var nav: UINavigationController { get set }
    var container: Container? { get }
    
    init(navigationController: UINavigationController)
    
    func start()
    func finish()
}

extension Coordinator {
    func childDidFinish(_ child: Coordinator) {
        removeChildCoordinator(child)
    }
    
    func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }

    func removeChildCoordinator(_ child: Coordinator) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }

    func removeAllChildCoordinators() {
        childCoordinators.removeAll()
    }
}
