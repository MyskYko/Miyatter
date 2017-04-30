//
//  CreateTweetViewModel.swift
//  Miyatter
//
//  Created by miyasaka on 2017/04/26.
//  Copyright © 2017年 miyacc. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

final class CreateTweetViewModel: CreateFormViewModel {
    
    // MARK: - Properties -

    let disposeBag =  DisposeBag()
    
    let buttonTitle = "ツイート投稿"
    
    
    // MARK: - Inputs -
    
    let submitForm = PublishSubject<String>()
    
    
    // MARK: - Initializers -
    
    init() {
        submitForm
            .subscribe(onNext: { (text) in
                print("tweet submittion")
                let realm = try! Realm()
                try! realm.write() {
                    let tweet = Tweet()
                    tweet.content = text
                    tweet.setId()
                    realm.add(tweet)
                }
            })
            .disposed(by: disposeBag)
    }
}
