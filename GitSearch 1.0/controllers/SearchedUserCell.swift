//
//  SearchedUserCell.swift
//  GitSearch 1.0
//
//  Created by Ravi Thakur on 18/10/20.
//

import UIKit

class SearchedUserCell: UITableViewCell {

    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var cards: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        cards.layer.cornerRadius = 12
        cards.layer.borderWidth = 0.5
        cards.layer.borderColor = UIColor.black.cgColor
    }
  

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
