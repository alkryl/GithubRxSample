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

class MainViewController: UIViewController {
    
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
    
    @IBOutlet weak var chooseView: ChooseView!
    
    //MARK: ViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.selectedLanguage.asObservable()
            .filter { $0.count > 0 }
            .do(onNext: { language in
                self.navigator.show(.list(language), sender: self)
            }).subscribe()
            .disposed(by: db)
        
        chooseView.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { (tap) in
                self.handleTap(tap)
            }).disposed(by: db)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        title = "Main"
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        chooseView.animate { [weak self] in
            self?.chooseView.hideSubviews.onNext(false)
        }
    }
    
    //MARK: Private
    
    private func handleTap(_ sender: UITapGestureRecognizer) {
        chooseView.hideSubviews.onNext(true)
        let handler: () -> () = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.navigator.show(.language(strongSelf.viewModel.selectedLanguage),
                                      sender: strongSelf)
        }
        chooseView.animate(scale: 2.5, size: CGSize(width: 100, height: 65),
                           radius: 10.0, handler)
    }
}
