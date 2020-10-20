//
//  histroyTableViewCell.swift
//  GitSearch 1.0
//
//  Created by Ravi Thakur on 19/10/20.
//

import UIKit

class histroyTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var Himage: UIImageView!
    @IBOutlet weak var HName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
