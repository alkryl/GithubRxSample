//
//  ListViewController.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 26/05/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    private var navigator: Navigator!
    private var viewModel: ListViewModel!
    
    static func createWith(navigator: Navigator,
                           storyboard: UIStoryboard,
                           viewModel: ListViewModel) -> ListViewController {
        let vc = storyboard.instantiateViewController(ofType: ListViewController.self)
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
