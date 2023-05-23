//
//  TableViewCell.swift
//  CRUDTry
//
//  Created by DA MAC M1 144 on 2023/05/23.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var ageLabel: UILabel!
    
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
