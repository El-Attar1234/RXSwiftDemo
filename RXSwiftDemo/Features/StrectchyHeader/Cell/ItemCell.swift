//
//  ItemCell.swift
//  RXSwiftDemo
//
//  Created by Ibtikar on 04/01/2023.
//

import UIKit

class ItemCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setup(title: String) {
        titleLabel.text = title
    }
    
}
