//
//  UIViewController+RxAlert.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 11/06/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import RxSwift

extension UIViewController {
    func showAlert(title: String = .empty,
                   description: String?,
                   closureToExecute: (() -> ())? = nil) -> Observable<Void> {
        return Observable.create({ [weak self] observer in
            let alert = UIAlertController(title: title,
                                          message: description,
                                          preferredStyle: .alert)
            let closeAction = UIAlertAction(title: "Close", style: .default, handler: { _ in
                alert.dismiss(animated: true, completion: nil)
                observer.onCompleted()
            })
            alert.addAction(closeAction)
            self?.present(alert, animated: true, completion: nil)
            return Disposables.create()
        })
    }
}
