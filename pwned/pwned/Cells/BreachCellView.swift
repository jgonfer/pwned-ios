//
//  BreachCellView.swift
//  pwned
//
//  Created by Josep Gonzalez Fernandez on 17/7/17.
//  Copyright © 2017 Dreams Corner. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class BreachCellView: UITableViewCell {
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func update(with breach: Breach) {
        name.text = breach.name
        logo.kf.setImage(with: URL(string: breach.imageUrl))
    }
}
