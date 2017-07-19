//
//  CustomTableViewCell.swift
//  baemin_fresh_tableview_practice
//
//  Created by woowabrothers on 2017. 7. 18..
//  Copyright © 2017년 woowabrothers_dain. All rights reserved.
//

import Foundation
import UIKit

class CustomTableViewCell: UITableViewCell {
    
    
    
    
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descript: UILabel!
    @IBOutlet weak var n_price: UILabel!
    @IBOutlet weak var s_price: UILabel!
    @IBOutlet weak var badge1: UILabel!
    @IBOutlet weak var badge2: UILabel!
    @IBOutlet weak var badge3: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
