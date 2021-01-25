//
//  MainViewModel.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 27/05/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import RxSwift
import RxCocoa

struct MainViewModel {
    
    //MARK: Rx
    
    private(set) var selectedLanguage = BehaviorRelay<String>(value: .empty)
}
