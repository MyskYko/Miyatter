//
//  CreateFormViewModel.swift
//  Miyatter
//
//  Created by miyasaka on 2017/04/29.
//  Copyright © 2017年 miyacc. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

protocol CreateFormViewModel {
    
    // MARK: - Properties -
    
    var disposeBag: DisposeBag { get }
    var buttonTitle: String { get }
    
    
    // MARK: - Inputs -
    
    var submitForm: PublishSubject<String> { get }
}
