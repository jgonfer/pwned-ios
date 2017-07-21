//
//  SearchViewModel.swift
//  pwned
//
//  Created by Josep Gonzalez Fernandez on 17/7/17.
//  Copyright © 2017 Dreams Corner. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift
import RxRealm
import RxDataSources
import Action

class SearchViewModel {
    private let bag = DisposeBag()
    let apiType: PwnedAPIProtocol.Type
    
    // MARK: - Input
    let email = Variable<String>("")
    
    // MARK: - Output
    private(set) var breaches: Observable<(AnyRealmCollection<Breach>, RealmChangeset?)>!
    var breachesList: Observable<[Breach]>
    
    // MARK: - Init
    init(apiType: PwnedAPIProtocol.Type = PwnedAPI.self) {
        self.apiType = apiType
        
        breachesList = Observable.just([])
        
        bindOutput()
        
        breachesList
            .subscribe(Realm.rx.add(update: true))
            .addDisposableTo(bag)
    }
    
    func bindOutput() {
        //observe the current account status
        breachesList = email.asObservable()
            .filter { email in
                guard !email.isEmpty else {
                    return false
                }
                return true
            }
            .distinctUntilChanged()
            .flatMap { email -> Observable<[JSONObject]> in
                print(email)
                return PwnedAPI.breaches(of: email)
            }
            .map(Breach.unboxMany)
            .shareReplayLatestWhileConnected()
        
        
        guard let realm = try? Realm() else {
            return
        }
        breaches = Observable.changesetFrom(realm.objects(Breach.self))
    }
}
