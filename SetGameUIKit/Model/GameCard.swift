//
//  GameCard.swift
//  SetGameUIKit
//
//  Created by Hui Chih Wang on 2021/5/27.
//

import Foundation

struct GameCard {
    let shape: Shape
    let shading: Shading
    let number : Number
    let color: Color
    
    var isSelected = false
    var isMatched = false
    
    enum Shading: String, CaseIterable {
        case solid
        case striped
        case open
    }
    
    enum Shape: String, CaseIterable {
        case diamond
        case squiggle
        case oval
    }
    
    enum Number: Int, CaseIterable {
        case one
        case two
        case three
    }
    enum Color: CaseIterable {
        case red
        case green
        case purple
    }
}

extension GameCard: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(shape)
        hasher.combine(shading)
        hasher.combine(number)
        hasher.combine(color)
    }
}
