//
//  Navigator.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 26/05/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import RxSwift
import RxCocoa

class Navigator {
    lazy private var defaultStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    //MARK: Segues
    
    enum Segue {
        case main
        case language(BehaviorRelay<String>)
        case list(String)
        case description(String)
    }
    
    //MARK: Methods
    
    func show(_ segue: Segue, sender: UIViewController) {
        let storyboard = sender.storyboard ?? defaultStoryboard
        
        switch segue {
        case .main:
            let vm = MainViewModel()
            let vc = MainViewController.createWith(navigator: self,
                                                   storyboard: storyboard,
                                                   viewModel: vm)
            show(target: vc, sender: sender)
        case .language(let lang):
            let vm = LanguageViewModel(language: lang)
            let vc = LanguageViewController.createWith(navigator: self,
                                                       storyboard: storyboard,
                                                       viewModel: vm)
            show(target: vc, sender: sender, modally: true)
        case .list(let lang):
            let vm = ListViewModel(language: lang)
            let vc = ListViewController.createWith(navigator: self,
                                                   storyboard: storyboard,
                                                   viewModel: vm)
            show(target: vc, sender: sender)
        case .description(let repo):
            let vm = DescriptionViewModel(repository: repo)
            let vc = DescriptionViewController.createWith(navigator: self,
                                                          storyboard: storyboard,
                                                          viewModel: vm)
            show(target: vc, sender: sender)
        }
    }
    
    func dismissModalController(_ controller: UIViewController, animated: Bool = false) {
        controller.dismiss(animated: animated, completion: nil)
    }
        
    //MARK: Private
    
    private func show(target: UIViewController, sender: UIViewController, modally: Bool = false) {
        if let nav = sender as? UINavigationController {
            nav.pushViewController(target, animated: false)
            return
        }
        
        if let nav = sender.navigationController, !modally {
            nav.pushViewController(target, animated: true)
        } else {
            sender.present(target, animated: true, completion: nil)
        }
    }
}
