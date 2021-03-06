//
//  GameCardView.swift
//  SetGameUIKit
//
//  Created by Hui Chih Wang on 2021/5/30.
//

import UIKit

class GameCardView: UIView {
    
    var card: GameCard? {
        didSet {
            clearStack()
            configureView()
        }
    }
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(frame: bounds.zoom(ratio: 0.8))
            stackView.alignment = .fill
            stackView.distribution = .fillEqually
            stackView.spacing = 5
            stackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addSubview(stackView)
        
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        return stackView
    }()
    
    private func configureView() {
        guard card != nil else {
            backgroundColor = .clear
            return
        }
        
        (0..<card!.number.rawValue).forEach { _ in
            stackView.addArrangedSubview(ShapeView())
        }
        
        stackView.arrangedSubviews.forEach { view in
            (view as? ShapeView)?.drawingAttribute = ShapeView.DrawingProperty(shape: shape, shading: shading, color: shapeColor)
        }
        
        if let card = card {
            setBackGroundColor(with: card)
            setBoarderColor(with: card)
        }
    }
    
    private func clearStack() {
        stackView.arrangedSubviews.forEach{ $0.removeFromSuperview() }
        stackView.axis = UIDevice.current.orientation.isLandscape ? .horizontal : .vertical
    }
    
}

extension GameCardView {
    var shape: ShapeView.Shape {
        switch card?.shape {
        case .circle:
            return .oval
        case .square:
            return .diamond
        default:
            return .squiggle
        }
    }
    
    var shading: ShapeView.Shading {
        switch card?.shading {
        case .solid:
            return .solid
        case .striped:
            return .stripe
        default:
            return .stroke
        }
    }
    
    var shapeColor: UIColor {
        switch card?.color {
        case .red:
            return #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        case .green:
            return #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        default:
            return #colorLiteral(red: 0.5607843137, green: 0.2705882353, blue: 0.5254901961, alpha: 1)
        }
    }
    
    private func setBackGroundColor(with card: GameCard) {
        if card.isMatched {
            backgroundColor = GameCardView.matchedcolor
        }
        else {
            backgroundColor = card.isSelected ? GameCardView.selectedColor : GameCardView.defaultColor
        }
    }
    
    private func setBoarderColor(with card: GameCard) {
        layer.cornerRadius = GameCardView.cornerRadius
        layer.borderWidth = GameCardView.borderWidth
        let boarderColor = card.isSelected ? GameCardView.selectedBorderColor : GameCardView.UnselectedBorderColor
        layer.borderColor = boarderColor.cgColor
    }
}

extension GameCardView {
    private static let selectedColor = #colorLiteral(red: 0.8431372549, green: 0.9764705882, blue: 1, alpha: 1)
    private static let defaultColor = #colorLiteral(red: 0.9764705882, green: 0.9843137255, blue: 0.9490196078, alpha: 1)
    private static let matchedcolor = #colorLiteral(red: 0.6862745098, green: 0.7960784314, blue: 1, alpha: 1)
    
    private static let selectedBorderColor = UIColor.red
    private static let UnselectedBorderColor = UIColor.black
    private static let borderWidth: CGFloat = 5
    private static let cornerRadius: CGFloat = 25
}

extension CGRect {
    func zoom(ratio: CGFloat) -> CGRect {
        let center = CGPoint(x: (minX + maxX) / 2, y: (minY + maxY) / 2)
        let resizedWidth = width * ratio
        let resizedHeight = height * ratio
        
        return CGRect(x: center.x - resizedWidth / 2, y: center.y - resizedHeight / 2, width: resizedWidth, height: resizedHeight)
    }
}
