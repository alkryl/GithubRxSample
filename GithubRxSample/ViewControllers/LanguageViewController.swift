//
//  LanguageViewController.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 26/05/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import UIKit

class LanguageViewController: UIViewController {
    
    private var navigator: Navigator!
    private var viewModel: LanguageViewModel!
    
    static func createWith(navigator: Navigator,
                           storyboard: UIStoryboard,
                           viewModel: LanguageViewModel) -> LanguageViewController {
        let vc = storyboard.instantiateViewController(ofType: LanguageViewController.self)
        vc.navigator = navigator
        vc.viewModel = viewModel
        return vc
    }
    
    //MARK: ViewController lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}
