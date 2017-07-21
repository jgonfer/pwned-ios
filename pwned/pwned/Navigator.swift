//
//  Navigator.swift
//  pwned
//
//  Created by Josep Gonzalez Fernandez on 17/7/17.
//  Copyright © 2017 Dreams Corner. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa

class Navigator {
    lazy private var defaultStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    // MARK: - segues list
    enum Segue {
        case listBreachesSearch()
    }
    
    // MARK: - invoke a single segue
    func show(segue: Segue, sender: UIViewController) {
        switch segue {
        case .listBreachesSearch():
            //show the combined timeline for the list
            let vm = SearchViewModel()
            show(target: SearchViewController.createWith(navigator: self, storyboard: sender.storyboard ?? defaultStoryboard, viewModel: vm), sender: sender)
            
        }
    }
    
    private func show(target: UIViewController, sender: UIViewController) {
        if let nav = sender as? UINavigationController {
            //push root controller on navigation stack
            nav.pushViewController(target, animated: false)
            return
        } else if let tab = sender as? UITabBarController {
            if let _ = target as? SearchViewController {
                var controllers = tab.viewControllers!
                let nc = UINavigationController(rootViewController: target)
                controllers[0] = nc
                tab.setViewControllers(controllers, animated: false)
            }
            return
        }
        
        if let nav = sender.navigationController {
            //add controller to navigation stack
            nav.pushViewController(target, animated: true)
        } else if let tab = sender.tabBarController {
            if let _ = target as? SearchViewController {
                tab.selectedIndex = 0
            }
        } else {
            //present modally
            sender.present(target, animated: true, completion: nil)
        }
    }
}
