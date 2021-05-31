//
//  CardViewCell.swift
//  SetGameUIKit
//
//  Created by Hui Chih Wang on 2021/5/27.
//

import UIKit

class CardViewCell: UICollectionViewCell {
    func configure(with card: GameCard) {
        guard !card.isEmptyCard else {
            return
        }
        
        (contentView as? GameCardView)?.card = card
    }
    
    
}
