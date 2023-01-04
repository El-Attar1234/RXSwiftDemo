//
//  TabCell.swift
//  RXSwiftDemo
//
//  Created by Ibtikar on 31/12/2022.
//

import UIKit

class TabCell: UICollectionViewCell {

    @IBOutlet private weak var selectionIndicatorView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleLabel.alpha = 0.6
        selectionIndicatorView.backgroundColor = .clear
    }

    func setup(text: String){
        titleLabel.text = text
    }
    
    override var isSelected: Bool {
        didSet {
            UIView.animate(withDuration: 0.2) {
                self.titleLabel.alpha =  self.isSelected ? 1 : 0.6
                self.selectionIndicatorView.backgroundColor =   self.isSelected ? .red : .clear
            }
           
        }
    }
}

