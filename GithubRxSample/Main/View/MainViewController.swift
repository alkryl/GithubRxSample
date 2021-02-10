//
//  MainViewController.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 27/05/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

final class MainViewController: UIViewController {
    
    var viewModel: MainViewModel!
    var showLanguagesAction: ((BehaviorRelay<String>) -> ())?
    var showRepositoriesAction: ((String) -> ())?
    
    //MARK: Rx
    
    private let db = DisposeBag()
    
    //MARK: Outlets
    
    @IBOutlet private weak var chooseView: ChooseView!
    
    //MARK: ViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribe()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar(true, animated: false)
        hideBackButtonText()
        chooseView.animate()
    }
    
    //MARK: Private
    
    private func handleTap() {
        chooseView.animate(with: { [weak self] in
            guard let self = self else { return }
            let relay = self.viewModel.selectedLanguage
            self.showLanguagesAction?(relay)
        })
    }
}

extension MainViewController: Subscriber {
    func subscribe() {
        viewModel.selectedLanguage
            .filter { !$0.isEmpty }
            .do(onNext: { [weak self] language in
                self?.showRepositoriesAction?(language)
            }).subscribe()
            .disposed(by: db)
        
        chooseView.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                self?.handleTap()
            }).disposed(by: db)
    }
}
