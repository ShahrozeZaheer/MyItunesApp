//
//  EntityTableViewCell.swift
//  MyiTunes
//
//  Created by Afroz on 04/11/2020.
//

import UIKit

class EntityTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
