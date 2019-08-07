//
//  TableViewCell.swift
//  weatherMe
//
//  Created by Student Loaner 3 on 8/5/19.
//  Copyright © 2019 Student Loaner 3. All rights reserved.
//

import UIKit

class MoodCell: UITableViewCell {

   
    @IBOutlet weak var moodImg: UILabel!
    @IBOutlet weak var moodTitle: UILabel!
    @IBOutlet weak var dateTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
