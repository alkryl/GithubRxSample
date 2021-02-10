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

final class LanguageViewController: UIViewController {
    
    var viewModel: LanguageViewModel!
    var dismissAction: (() -> ())?
    
    //MARK: Rx
    
    private let db = DisposeBag()
    
    //MARK: Outlets
    
    @IBOutlet private weak var languagePicker: UIPickerView!
    @IBOutlet private weak var confirmButton: ConfirmButton!
    
    //MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        subscribe()
    }
}

//MARK: Subscriber

extension LanguageViewController: Subscriber {
    func subscribe() {
        viewModel.languages
            .bind(to: languagePicker.rx.itemTitles) { String($1) }
            .disposed(by: db)
        
        confirmButton.rx.tap
            .throttle(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .do(onNext: { [weak self] in
                self?.dismissAction?()
            }).compactMap { [weak self] in
                self?.languagePicker.selectedRow(inComponent: .zero)
            }.bind(to: viewModel.selectedRow)
            .disposed(by: db)
    }
}
