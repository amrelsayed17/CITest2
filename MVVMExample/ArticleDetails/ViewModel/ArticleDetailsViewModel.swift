//
//  ArticleDetailsViewModel.swift
//  MVVMExample
//
//  Created by Mac on 1/31/22.
//

import UIKit
import RxSwift
import RxCocoa

class ArticleDetailsViewModel: NSObject {

    private var articleModelSubject=PublishSubject<Result>()
    
    var articleModelObservable:Observable<Result>{
        return articleModelSubject
    }
    
    func setValue(article:Result) {
        articleModelSubject.onNext(article)
    }
    
}
