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
    
    private var navigator: Navigator!
    private var viewModel: MainViewModel!
    private let db = DisposeBag()
    
    static func createWith(navigator: Navigator,
                           storyboard: UIStoryboard,
                           viewModel: MainViewModel) -> MainViewController {
        let vc = storyboard.instantiateViewController(ofType: MainViewController.self)
        vc.navigator = navigator
        vc.viewModel = viewModel
        return vc
    }
    
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
        chooseView.animate()
    }
    
    //MARK: Private
    
    private func handleTap() {
        chooseView.animate(with: { [weak self] in
            guard let self = self else { return }
            self.navigator.show(.language(self.viewModel.selectedLanguage),
                                sender: self)
        })
    }
}

extension MainViewController: Subscriber {
    func subscribe() {
        viewModel.selectedLanguage
            .filter { !$0.isEmpty }
            .do(onNext: { [weak self] language in
                guard let self = self else { return }
                self.navigator.show(.list(language), sender: self)
            }).subscribe()
            .disposed(by: db)
        
        chooseView.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                self?.handleTap()
            }).disposed(by: db)
    }
}
