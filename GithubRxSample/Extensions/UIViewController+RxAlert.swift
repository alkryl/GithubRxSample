//
//  UIViewController+RxAlert.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 11/06/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import RxSwift

extension UIViewController {
    func showAlert(title: String, description: String?,
                   closureToExecute: (() -> ())?) -> Observable<Void> {
        return Observable.create({ [weak self] observer in
            let alert = UIAlertController(title: title,
                                          message: description,
                                          preferredStyle: .alert)
            let closeAction = UIAlertAction(title: "Close", style: .default, handler: { _ in
                alert.dismiss(animated: true, completion: nil)
                observer.onCompleted()
            })
            let showAction = UIAlertAction(title: "Show", style: .default, handler: { _ in
                if let closure = closureToExecute {
                    closure()
                } else {
                    alert.dismiss(animated: true, completion: nil)
                }
                observer.onCompleted()
            })
            alert.addAction(closeAction)
            alert.addAction(showAction)
            self?.present(alert, animated: true, completion: nil)
            return Disposables.create()
        })
    }
}
