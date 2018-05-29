//
//  FruitsTableViewCell.swift
//  SuggestionBar
//
//  Created by Ricardo V Del Frari on 28/05/2018.
//  Copyright © 2018 Ricardo V Del Frari. All rights reserved.
//

import UIKit

class FruitsTableViewCell: UITableViewCell {

    @IBOutlet weak var fruitEmojiLabel: UILabel!
    @IBOutlet weak var fruitNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
