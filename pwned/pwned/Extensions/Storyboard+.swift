//
//  Storyboard+.swift
//  pwned
//
//  Created by Josep Gonzalez Fernandez on 17/7/17.
//  Copyright © 2017 Dreams Corner. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    func instantiateViewController<T>(ofType type: T.Type) -> T {
        return instantiateViewController(withIdentifier: String(describing: type)) as! T
    }
}
