//
//  MainCoordinator.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 28.01.2021.
//  Copyright © 2021 Alexander Krylov. All rights reserved.
//

import UIKit
import Swinject
import RxSwift
import RxCocoa

extension MainCoordinator {
    enum Target {
        case main
        case language(BehaviorRelay<String>)
        case list(String)
        case description(String)
        case code(String, String)
    }
}

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController?
    var container: Container?
    
    func start() {
        show(.main)
    }
    
    func show(_ target: Target) {
        switch target {
        case .main:
            showMain()
        case let .language(value):
            showLanguages(value)
        case let .list(language):
            showRepositories(language)
        case let .description(name):
            showCommits(name)
        case let .code(name, hash):
            showCode(name, hash)
        }
    }
    
    func dismiss(_ source: UIViewController) {
        source.dismiss(animated: false, completion: nil)
    }
    
    //MARK: Private
    
    private func showMain() {
        guard let target = container?.resolve(MainViewController.self, argument: self) else { return }
        navigationController?.pushViewController(target, animated: false)
    }
    
    private func showLanguages(_ relay: BehaviorRelay<String>) {
        guard let sender = container?.resolve(MainViewController.self, argument: self),
              let target = container?.resolve(LanguageViewController.self, arguments: self, relay)
        else { return }
        sender.present(target, animated: true, completion: nil)
    }
    
    private func showRepositories(_ language: String) {
        guard let target = container?.resolve(ListViewController.self, arguments: self, language) else { return }
        navigationController?.pushViewController(target, animated: true)
    }
    
    private func showCommits(_ name: String) {
        guard let target = container?.resolve(CommitsViewController.self, arguments: self, name)
            else { return }
        navigationController?.pushViewController(target, animated: true)
    }
    
    private func showCode(_ name: String, _ hash: String) {
        guard let target = container?.resolve(CodeViewController.self, arguments: self, name, hash)
            else { return }
        navigationController?.pushViewController(target, animated: true)
    }
}
