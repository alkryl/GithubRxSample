//
//  LanguageViewController.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 26/05/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LanguageViewController: UIViewController {
    
    private var navigator: Navigator!
    private var viewModel: LanguageViewModel!
    private let db = DisposeBag()
    
    static func createWith(navigator: Navigator,
                           storyboard: UIStoryboard,
                           viewModel: LanguageViewModel) -> LanguageViewController {
        let vc = storyboard.instantiateViewController(ofType: LanguageViewController.self)
        vc.navigator = navigator
        vc.viewModel = viewModel
        return vc
    }
    
    //MARK: Outlets
    
    @IBOutlet weak var languagePicker: UIPickerView!
    @IBOutlet weak var confirmButton: ConfirmButton!
    
    //MARK: ViewController lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
    }
    
    //MARK: Bindings
    
    private func bindUI() {
        viewModel.languages
            .bind(to: languagePicker.rx.itemTitles) { String($1) }
            .disposed(by: db)
        
        let tapObservable = confirmButton.rx.tap.share()
        
        tapObservable
            .map { [unowned self] in
                self.languagePicker.selectedRow(inComponent: 0)
            }.bind(to: viewModel.selectedRow)
            .disposed(by: db)
        
        tapObservable
            .subscribe(onNext: { [unowned self] in
                self.navigator.dismissModalController(self)
            }).disposed(by: db)
    }
}
