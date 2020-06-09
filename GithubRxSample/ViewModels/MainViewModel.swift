//
//  MainViewModel.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 27/05/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct MainViewModel {
    
    var selectedLanguage = BehaviorRelay(value: "")
}
