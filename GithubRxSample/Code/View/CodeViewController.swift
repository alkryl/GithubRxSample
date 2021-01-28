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
    
    var viewModel: CodeViewModel!
    
    //MARK: Rx
    
    private let db = DisposeBag()
    
    //MARK: Outlets
    
    @IBOutlet private weak var webView: WKWebView!
    
    //MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        subscribe()
    }
}

//MARK: Subscriber

extension CodeViewController: Subscriber {
    func subscribe() {
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: db)
        
        viewModel.request
            .subscribe { [weak self] request in
                self?.webView.load(request)
            }.disposed(by: db)
    }
}
