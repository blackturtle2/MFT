//
//  MainTextListCell.swift
//  MFT
//
//  Created by leejaesung on 2018. 1. 14..
//  Copyright © 2018년 blackturtle2. All rights reserved.
//

import UIKit

class MainTextListCell: UITableViewCell {

    @IBOutlet weak var imageViewIcon: UIImageView!
    @IBOutlet weak var labelText: UILabel!
    
    var thisData: [String]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
