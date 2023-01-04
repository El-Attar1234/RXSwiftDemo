//
//  DemoCell.swift
//  RXSwiftDemo
//
//  Created by Ibtikar on 28/12/2022.
//

import UIKit

class DemoCell: UICollectionViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setup(title: String?) {
        titleLabel.text = title
    }

}
