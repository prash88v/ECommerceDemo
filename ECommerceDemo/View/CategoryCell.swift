//
//  CategoryCell.swift
//  ECommerceDemo
//
//  Created by Prashant  on 3/9/20.
//  Copyright © 2020 Prashant. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
    
    @IBOutlet weak var lblCategoryName : UILabel?
    
    @IBOutlet weak var lblPrice : UILabel?
    @IBOutlet weak var lblSize : UILabel?
    @IBOutlet weak var categoryView: UIView?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
