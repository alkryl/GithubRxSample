//
//  LanguageCoordinator.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 04.02.2021.
//  Copyright © 2021 Alexander Krylov. All rights reserved.
//

import UIKit
import Swinject
import RxSwift
import RxCocoa

class LanguageCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var nav: UINavigationController
    var container: Container?
    
    //MARK: Properties
    
    var languageRelay: BehaviorRelay<String>?
    var childDidFinish: CoordinatorClosure?
    
    //MARK: Initialization
    
    required init(navigationController: UINavigationController) {
        nav = navigationController
    }
    
    //MARK: Coordinator
        
    func start() {
        guard let source = container?.resolve(MainViewController.self),
              let target = languageController()
        else { return }
                
        target.dismissAction = dismissAction
        
        source.present(target, animated: true, completion: nil)
    }
    
    func finish() {
        guard let vc = languageController() else { return }
        
        vc.dismiss(animated: false, completion: nil)
        
        childDidFinish?(self)
    }
    
    //MARK: Private
    
    private func languageController() -> LanguageViewController? {
        guard let relay = languageRelay,
              let vc = container?.resolve(LanguageViewController.self, argument: relay)
        else { return nil }
        
        return vc
    }
}

//MARK: Computed properties

extension LanguageCoordinator {
    private var dismissAction: EmptyClosure {
        return { [weak self] in
            self?.finish()
        }
    }
}
