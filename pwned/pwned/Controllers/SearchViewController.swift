//
//  SearchViewController.swift
//  pwned
//
//  Created by Josep Gonzalez Fernandez on 13/7/17.
//  Copyright © 2017 Dreams Corner. All rights reserved.
//

import UIKit
import RxSwift
import Then
import RxRealmDataSources

class SearchViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var optionsHeightConstant: NSLayoutConstraint!
    
    private let bag = DisposeBag()
    fileprivate var viewModel: SearchViewModel!
    fileprivate var navigator: Navigator!
    
    static func createWith(navigator: Navigator, storyboard: UIStoryboard, viewModel: SearchViewModel) -> SearchViewController {
        return storyboard.instantiateViewController(ofType: SearchViewController.self).then { vc in
            vc.navigator = navigator
            vc.viewModel = viewModel
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Search"
        tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(UINib(nibName: "BreachCellView", bundle: nil), forCellReuseIdentifier: "BreachCellView")
        
        bindUI()
        
        viewModel.email.value = "info@google.com"
    }
    
    func bindUI() {
        //bind button to the people view controller
        /*navigationItem.rightBarButtonItem!.rx.tap
            .throttle(0.5, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                guard let this = self else { return }
                this.navigator.show(segue: .listPeople(this.viewModel.account,
                                                       this.viewModel.list), sender: this)
            })
            .addDisposableTo(bag)
        */
        
        searchBar.rx.searchButtonClicked
            .subscribe(onNext: { _ in
                print(self.searchBar.text!)
                self.viewModel.email.value = self.searchBar.text!
            })
            .addDisposableTo(bag)
        
        //show breaches in table view
        let dataSource = RxTableViewRealmDataSource<Breach>(cellIdentifier: "BreachCellView", cellType: BreachCellView.self) { cell, _, breach in
            print(breach)
            cell.update(with: breach)
        }
        
        viewModel.breaches
            .bind(to: tableView.rx.realmChanges(dataSource))
            .addDisposableTo(bag)
        
        //show message when no account available
        /*viewModel.loggedIn
            .drive(messageView.rx.isHidden)
            .addDisposableTo(bag)*/
    }
}
