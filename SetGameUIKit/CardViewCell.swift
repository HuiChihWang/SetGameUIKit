//
//  CardViewCell.swift
//  SetGameUIKit
//
//  Created by Hui Chih Wang on 2021/5/27.
//

import UIKit

class CardViewCell: UICollectionViewCell {
    
    @IBOutlet weak var stackView: UIStackView!
    
    func configure(with card: GameCard) {
        
        print("configure card: \(card)")
        let colorLabel = UILabel()
        colorLabel.text = card.color.rawValue
        stackView.addSubview(colorLabel)
        
        let numberLabel = UILabel()
        numberLabel.text = "\(card.number.rawValue)"
        stackView.addSubview(numberLabel)
        
        let shapeLabel = UILabel()
        shapeLabel.text = card.shape.rawValue
        stackView.addSubview(shapeLabel)
        
        let shadingLabel = UILabel()
        shadingLabel.text = card.shading.rawValue
        stackView.addSubview(shadingLabel)
        
        contentView.backgroundColor = card.isSelected ? .yellow : .green
    }
}
