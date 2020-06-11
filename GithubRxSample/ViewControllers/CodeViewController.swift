//
//  CodeViewController.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 11/06/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import WebKit

class CodeViewController: UIViewController {
    
    private var navigator: Navigator!
    private var viewModel: CodeViewModel!
    private let db = DisposeBag()
    
    static func createWith(navigator: Navigator,
                           storyboard: UIStoryboard,
                           viewModel: CodeViewModel) -> CodeViewController {
        let vc = storyboard.instantiateViewController(ofType: CodeViewController.self)
        vc.navigator = navigator
        vc.viewModel = viewModel
        return vc
    }
    
    //MARK: Outlets
    
    @IBOutlet weak var webView: WKWebView!
    
    //MARK: ViewController lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
    }
    
    //MARK: Private
    
    private func bindUI() {
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: db)
        
        viewModel.request
            .subscribe(onNext: {
                self.webView.load($0)
            }).disposed(by: db)
    }
}
