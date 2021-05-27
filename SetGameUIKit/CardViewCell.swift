//
//  CardViewCell.swift
//  SetGameUIKit
//
//  Created by Hui Chih Wang on 2021/5/27.
//

import UIKit

class CardViewCell: UICollectionViewCell {
    
    private lazy var label: UILabel = {
        let label = UILabel(frame: contentView.frame)
        contentView.addSubview(label)
        
        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        label.textAlignment = .center
        label.font = label.font.withSize(30)
        return label
    }()

    private func getBorderColor(with card: GameCard) -> UIColor {
        switch card.color {
        case .red:
            return #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        case .green:
            return #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        case .purple:
            return #colorLiteral(red: 0.5607843137, green: 0.2705882353, blue: 0.5254901961, alpha: 1)
        }
    }
    
    private func getTextureColor(with card: GameCard) -> UIColor {
        let borderColor = getBorderColor(with: card)
        
        var alpha: CGFloat
        switch card.shading {
        case .open:
            alpha = 0
        case .striped:
            alpha = 0.5
        case .solid:
            alpha = 1
        }
        
        return borderColor.withAlphaComponent(alpha)
    }
    
    private func getFontSize(with card: GameCard) -> CGFloat {
        switch card.number {
        case .one:
            return 55
        case .two:
            return 45
        case .three:
            return 35
        }
    }
    
    func configure(with card: GameCard) {
        contentView.layer.cornerRadius = 25
        contentView.layer.borderWidth = 5
        contentView.layer.borderColor = card.isSelected ? UIColor.red.cgColor : UIColor.black.cgColor
        
        setBackGroundColor(with: card)
        
        let displayString = String(repeating: card.shape.rawValue, count: card.number.rawValue)
        let displayBorderColor = getBorderColor(with: card)
        let displayTextureColor = getTextureColor(with: card)
        let displayFont = UIFont.systemFont(ofSize: getFontSize(with: card))

        let attribute: [NSAttributedString.Key: Any] = [
            .font: displayFont,
            .strokeColor: displayBorderColor,
            .strokeWidth: -10.0,
            .foregroundColor: displayTextureColor,
        ]
        
        let attributeString = NSAttributedString(string: displayString, attributes: attribute)
        label.attributedText = attributeString
    }
    
    private func setBackGroundColor(with card: GameCard) {
        if card.isMatched {
            contentView.backgroundColor = .systemPink
        }
        else {
            contentView.backgroundColor = card.isSelected ? #colorLiteral(red: 0.7371590945, green: 0.7383333638, blue: 0.6638078027, alpha: 1) : #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.862745098, alpha: 1)
        }
    }
}
