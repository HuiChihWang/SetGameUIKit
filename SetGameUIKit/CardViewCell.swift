//
//  CardViewCell.swift
//  SetGameUIKit
//
//  Created by Hui Chih Wang on 2021/5/27.
//

import UIKit

class CardViewCell: UICollectionViewCell {

    override func prepareForReuse() {
        contentView.subviews.forEach { view in
            contentView.willRemoveSubview(view)
            view.removeFromSuperview()
        }
    }
    
    func configure(with card: GameCard) {
        
        let stackView = UIStackView(frame: contentView.frame)
        stackView.axis = .vertical
        
        let colorLabel = UILabel()
        colorLabel.text = card.color.rawValue
        stackView.addArrangedSubview(colorLabel)
        
        let numberLabel = UILabel()
        numberLabel.text = "\(card.number.rawValue)"
        stackView.addArrangedSubview(numberLabel)
        
        let shapeLabel = UILabel()
        shapeLabel.text = card.shape.rawValue
        stackView.addArrangedSubview(shapeLabel)
        
        let shadingLabel = UILabel()
        shadingLabel.text = card.shading.rawValue
        stackView.addArrangedSubview(shadingLabel)
        
        
        if card.isMatched {
            contentView.backgroundColor = .systemPink
        }
        else {
            contentView.backgroundColor = card.isSelected ? .yellow : .green
        }
        
        contentView.addSubview(stackView)
    }
}
