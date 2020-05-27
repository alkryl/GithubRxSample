//
//  Navigator.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 26/05/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import UIKit

class Navigator {
    lazy private var defaultStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    //MARK: Segues
    
    enum Segue {
        case language
        case list
        case description
    }
    
    //MARK: Methods
    
    func show(_ segue: Segue, sender: UIViewController) {
        let storyboard = sender.storyboard ?? defaultStoryboard
        
        switch segue {
        case .language:
            let vm = LanguageViewModel()
            let vc = LanguageViewController.createWith(navigator: self,
                                                       storyboard: storyboard,
                                                       viewModel: vm)
            show(target: vc, sender: sender)
        case .list:
            let vm = ListViewModel()
            let vc = ListViewController.createWith(navigator: self,
                                                   storyboard: storyboard,
                                                   viewModel: vm)
            show(target: vc, sender: sender)
        case .description:
            let vm = DescriptionViewModel()
            let vc = DescriptionViewController.createWith(navigator: self,
                                                          storyboard: storyboard,
                                                          viewModel: vm)
            show(target: vc, sender: sender)
        }
    }
    
    //MARK: Private
    
    private func show(target: UIViewController, sender: UIViewController) {
        if let nav = sender as? UINavigationController {
            nav.pushViewController(target, animated: false)
            return
        }
        
        if let nav = sender.navigationController {
            nav.pushViewController(target, animated: true)
        } else {
            sender.present(target, animated: true, completion: nil)
        }
    }
}
